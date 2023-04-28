# frozen_string_literal: true

RSpec.describe "DELETE sessions/:id", type: :request do
  subject(:request) { delete session_url(user.id) }

  let(:user) { create(:user) }

  before do
    login(user)

    request
  end

  context "when logged out" do
    it "returns success response" do
      expect(response).to have_http_status(:found)
      expect(response.body).to include(new_session_url)

      expect(cookies[:user_id]).to be_blank
    end
  end
end
