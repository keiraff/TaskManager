# frozen_string_literal: true

RSpec.describe "GET /users/:id", type: :request do
  subject(:request) { get user_url(user.id) }

  let(:user) { create(:user) }

  context "when user not authorized" do
    it "returns error" do
      request

      expect(response).to have_http_status(:found)
      expect(response.body).to include(new_session_url)
    end
  end

  context "when user authorized" do
    it "returns success responce" do
      login(user)

      request

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("text/html; charset=utf-8")
      expect(response.body).to include("Welcome to the page")
    end
  end
end
