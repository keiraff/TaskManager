# frozen_string_literal: true

RSpec.describe "GET /users/:id", type: :request do
  context "when user authenticated" do
    let(:user) { create(:user) }

    before do
      login(user)
    end

    it "returns success responce" do
      get "/users/#{user.id}"

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("text/html; charset=utf-8")
      expect(response.body).to include("Welcome to the page")
    end
  end

  it_behaves_like "unauthenticated user request", :get, "/users/1"
end
