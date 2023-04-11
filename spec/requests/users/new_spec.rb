# frozen_string_literal: true

RSpec.describe "Users", type: :request do
  describe "GET /new" do
    it "returns status code 200" do
      get new_user_url
      expect(response).to have_http_status(:ok)
    end
  end
end
