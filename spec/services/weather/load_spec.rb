# frozen_string_literal: true

RSpec.describe Weather::Load do
  subject(:service) do
    described_class.call(city: user.city, state_code: user.state, country_code: user.country,
                         date: event.starts_at, all_day: event.all_day)
  end

  context "when location blank" do
    let(:user) { create(:user) }
    let(:category) { create(:category, user: user) }
    let(:event) { create(:event, user: user, category: category) }

    it "returns failure" do
      expect(service.errors?).to be(true)
      expect(service.errors).to eq("Can't show forecast for this event. Specify your location in Settings.")
    end
  end

  context "when location set" do
    let(:user) { create(:user, city: "New York", state: "NY", country: "US") }
    let(:category) { create(:category, user: user) }

    context "when api error" do
      let(:event) { create(:event, starts_at: 17.days.from_now, user: user, category: category) }

      it "returns error", vcr: "weather_api_request_error" do
        expect(service.errors?).to be(true)
        expect(service.errors).to eq("Can't show forecast for this event. API request error.")
      end
    end

    context "when invalid data" do
      let(:event) { build(:event, starts_at: 3.months.ago, user: user, category: category) }

      before do
        event.save(validate: false)
      end

      it "returns error", vcr: "weather_api_invalid_response_data" do
        expect(service.errors?).to be(true)
        expect(service.errors).to eq("Can't show forecast for this event.")
      end
    end

    context "when valid data" do
      let(:event) { create(:event, user: user, category: category) }

      it "returns success", vcr: "weather_api_valid_response_data" do
        expect(service.success?).to be(true)
        expect(service.value.class).to be(Weather::Entity)
      end
    end
  end
end
