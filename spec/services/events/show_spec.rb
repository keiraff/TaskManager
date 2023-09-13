# frozen_string_literal: true

RSpec.describe Events::Show do
  subject(:service) { described_class.new(event, user) }

  context "when location blank" do
    let(:user) { create(:user) }
    let(:category) { create(:category, user: user) }
    let(:event) { create(:event, user: user, category: category) }

    before do
      service.call
    end

    it "returns failure" do
      expect(service.errors?).to be(true)
      expect(service.errors).to eq("Can't show forecast for this event. Specify your location in Settings.")
    end
  end

  context "when location set" do
    let(:user) { create(:user, city: "New York", state: "NY", country: "US") }
    let(:category) { create(:category, user: user) }
    let(:event) { create(:event, user: user, category: category) }

    before do
      VCR.use_cassette("weather_api_valid_response_data",
                       match_requests_on: [VCR.request_matchers.uri_without_param(:start_date, :end_date), :headers,
                                           :method, :body]) do
        service.call
      end
    end

    it "returns success" do
      expect(service.success?).to be(true)
      expect(service.value.class).to be(Weather::Entity)
    end
  end
end
