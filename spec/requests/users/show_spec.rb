# frozen_string_literal: true

RSpec.describe "GET /users/:id", type: :request do
  subject(:request) { get user_url(user.id) }

  let(:user) { create(:user) }

  context "when user not authenticated" do
    before do
      request
    end

    it "returns error" do
      expect(response).to have_http_status(:found)
      expect(response.body).to include(new_session_url)
    end
  end

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
