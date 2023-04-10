# frozen_string_literal: true

RSpec.describe "Sessions", type: :request do
  let(:user) { create(:user) }

  describe "DELETE /destroy" do
    context "when logging out" do
      before do
        post login_url, params: { email: user.email, password: user.password }
      end

      it "user logged in" do
        expect(response.body).to include(user_url(user.id))
      end

      it "returns status code 302" do
        expect(response).to have_http_status(:found)
      end

      it "redirects to login_url" do
        delete login_url(user.id)
        expect(response.body).to include(login_url)
      end
    end
  end
end
