# frozen_string_literal: true

RSpec.describe "DELETE sessions/:id", type: :request do
  let(:user) { create(:user) }

  context "when logging out" do
    it "returns success response" do
      login(user)

      expect(response.body).to include(user_url(user.id))

      logout(user)

      expect(response).to have_http_status(:found)
      expect(response.body).to include(new_session_url)
    end
  end
end
