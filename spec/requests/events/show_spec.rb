# frozen_string_literal: true

RSpec.describe "GET /events/:id", type: :request do
  context "when user authenticated" do
    context "when user location is set" do
      let(:user) { create(:user, city: "New York", state: "NY", country: "US") }
      let(:category) { create(:category, user: user) }

      before do
        login(user)
      end

      context "when get response with OK status" do
        context "when get valid data from external api" do
          let(:event) { create(:event, user: user, category: category) }

          it "returns success response", vcr: "weather_api_valid_response_data" do
            get "/events/#{event.id}"

            expect(response).to have_http_status(:ok)
            expect(response.body).to include("Temperature", "Precipitation probability")
          end
        end

        context "when get invalid data from external api" do
          let(:event) { build(:event, starts_at: 12.weeks.ago, user: user, category: category) }

          before do
            event.save(validate: false)
          end

          it "returns error", vcr: "weather_api_invalid_response_data" do
            get "/events/#{event.id}"

            expect(response).to have_http_status(:ok)
            expect(response.body).not_to include("Temperature", "Precipitation probability")
            expect(response.body).to include("Can't show forecast for this event.")
          end
        end
      end

      context "when API request error" do
        let(:event) { create(:event, starts_at: 17.days.from_now, user: user, category: category) }

        it "returns error", vcr: "weather_api_request_error" do
          get "/events/#{event.id}"

          expect(response).to have_http_status(:ok)
          expect(response.body).not_to include("Temperature", "Precipitation probability")
          expect(response.body).to include("Can't show forecast for this event. API request error.")
        end
      end
    end

    context "when user location is blank" do
      let(:user) { create(:user) }
      let(:category) { create(:category, user: user) }
      let(:event) { create(:event, user: user, category: category) }

      before do
        login(user)
      end

      it "returns success responce" do
        get "/events/#{event.id}"

        expect(response).to have_http_status(:ok)
        expect(response.body).to include(event.name, event.description,
                                         "Can't show forecast for this event. Specify your location in Settings.")
        expect(response.body).not_to include("Temperature", "Precipitation probability")
      end
    end
  end

  it_behaves_like "unauthenticated user request", :get, "/events/1"
end
