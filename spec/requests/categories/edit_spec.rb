# frozen_string_literal: true

RSpec.describe "GET /categories/:id/edit", type: :request do
  context "when user authenticated" do
    let(:user) { create(:user) }
    let(:category) { create(:category, user: user) }

    before do
      login(user)
    end

    it "returns success responce" do
      get "/categories/#{category.id}/edit"

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("text/html; charset=utf-8")
      expect(response.body).to include("Edit Category")
    end
  end

  it_behaves_like "unauthenticated user request", :get, "/categories/1/edit"
end
