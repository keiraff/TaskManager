# frozen_string_literal: true

RSpec.describe "Users", type: :request do
  let(:attributes) { attributes_for(:user) }

  describe "POST /create" do
    context "when user is valid" do
      before do
        post users_url, params: { user: attributes }
      end

      it "returns status code 302" do
        expect(response).to have_http_status(:found)
      end

      it "redirects to users/id" do
        expect(response.body).to include(new_session_url)
      end
    end

    context "when user is invalid" do
      before do
        post users_url, params: { user: { email: nil, password: nil } }
      end

      it "returns status code 302" do
        expect(response).to have_http_status(:found)
      end

      it "redirects to signup_url" do
        expect(response.body).to include(new_user_url)
      end
    end
  end
end
