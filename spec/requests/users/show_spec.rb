# frozen_string_literal: true

RSpec.describe "GET /users/:id", type: :request do
  subject(:request) { get user_url(user.id) }

  let(:user) { create(:user) }

  it_behaves_like "unauthenticated user request", "/sessions/new"

  context "when user authenticated" do
    before do
      login(user)

      request
    end

    it "returns success responce" do
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("text/html; charset=utf-8")
      expect(response.body).to include("Welcome to the page")
    end
  end
end
