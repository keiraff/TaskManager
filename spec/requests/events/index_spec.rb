# frozen_string_literal: true

RSpec.describe "GET /events", type: :request do
  context "when user authenticated" do
    let(:user) { create(:user) }

    let(:first_category) { create(:category, name: "Personal", user: user) }
    let(:second_category) { create(:category, name: "Work", user: user) }

    let(:first_event) { create(:event, name: "Trip to LA", user: user, category: first_category) }
    let(:second_event) { create(:event, name: "Trip to NYC", user: user, category: first_category) }
    let(:third_event) { create(:event, name: "Trip to Chicago", user: user, category: second_category) }
    let(:fourth_event) { create(:event, name: "Buy tickets", user: user, category: first_category) }

    before do
      login(user)

      first_category
      second_category

      first_event
      second_event
      third_event
      fourth_event
    end

    it "returns success responce" do
      get "/events", params: { query: { name_cont: "Trip", category_id_eq: first_category.id }, commit: "Search",
                               page: 2, per_page: 1 }

      expect(response).to have_http_status(:ok)

      expect(response.body).to include("Displaying items <b>2-2</b> of <b>2</b> in total", "Trip to NYC")
      expect(response.body).not_to include("Trip to LA", "Trip to Chicago", "Buy tickets")
    end
  end

  it_behaves_like "unauthenticated user request", :get, "/events"
end
