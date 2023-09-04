# frozen_string_literal: true

RSpec.describe "GET /events/:id", type: :request do
  context "when user authenticated" do
    context "when user location is blank" do
      let(:user) { create(:user) }
      let(:category) { create(:category, user: user) }
      let(:event) { create(:event, user: user, category: category) }

      before do
        login(user)
      end

      it "returns error message" do
        get "/events/#{event.id}"

        expect(response).to have_http_status(:ok)
        expect(response.body).to include(event.name, event.description,
                                         "Can't show forecast for this event. Specify your location in Settings.")
        expect(response.body).not_to include("Temperature", "Precipitation probability")
      end
    end

    context "when user location is specified" do
      let(:user) { create(:user, city: "New York", state: "NY", country: "US") }
      let(:category) { create(:category, user: user) }
      let(:event) { create(:event, user: user, category: category) }

      before do
        login(user)
      end

      it "returns success response", vcr: "weather_api_valid_response_data" do
        get "/events/#{event.id}"

        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Temperature", "Precipitation probability")
      end
    end

    it_behaves_like "unauthenticated user request", :get, "/events/1"
  end
end
