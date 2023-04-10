# frozen_string_literal: true

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  describe "GET /show" do
    context "when user not authorized" do
      before do
        get user_url(user.id)
      end

      it "returns status code 302" do
        expect(response).to have_http_status(:found)
      end

      it "redirects to login_url" do
        expect(response.body).to include(login_url)
      end
    end

    context "when user authorized" do
      before do
        post login_url, params: { email: user.email, password: user.password }
        get user_url(user.id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(:ok)
      end

      it "returns a valid html response" do
        expect(response.content_type).to eq("text/html; charset=utf-8")
      end

      it "shows users/id" do
        expect(response.body).to include("Welcome to the page")
      end
    end
  end
end
