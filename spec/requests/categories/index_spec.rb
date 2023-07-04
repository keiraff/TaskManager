# frozen_string_literal: true

RSpec.describe "GET /categories", type: :request do
  context "when user authenticated" do
    let(:user) { create(:user) }
    let(:work_category) { create(:category, name: "Work", user: user) }
    let(:personal1_category) { create(:category, name: "Personal1", user: user) }
    let(:personal2_category) { create(:category, name: "Personal2", user: user) }

    before do
      login(user)

      work_category
      personal1_category
      personal2_category
    end

    it "returns success responce" do
      get "/categories", params: { query: { name_cont: "Personal" }, commit: "Search", page: 2, per_page: 1 }

      expect(response).to have_http_status(:ok)

      expect(response.body).to include("Displaying items <b>2-2</b> of <b>2</b> in total")
      expect(response.body).to include("Personal1")
      expect(response.body).not_to include("Personal2", "Work")
    end
  end

  it_behaves_like "unauthenticated user request", :get, "/categories"
end
