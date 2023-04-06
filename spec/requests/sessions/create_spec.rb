# frozen_string_literal: true

RSpec.describe "Sessions", type: :request do
  let(:user) { create(:user) }

  describe "POST /create" do
    context "when user is valid" do
      before do
        post login_url, params: { email: user.email, password: user.password }
      end

      it { expect(user).to be_valid }

      it "returns status code 302" do
        expect(response).to have_http_status(:found)
      end

      it "redirects users/id" do
        expect(response.body).to include(user_url(user.id))
      end
    end

    context "when user is invalid" do
      before do
        post login_url, params: { email: nil, password: nil }
      end

      it "returns status code 302" do
        expect(response).to have_http_status(:found)
      end

      it "redirects to login_url" do
        expect(response.body).to include(login_url)
      end
    end
  end
end
