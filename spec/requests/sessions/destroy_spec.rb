# frozen_string_literal: true

RSpec.describe "DELETE sessions/:id", type: :request do
  context "when user authenticated" do
    let(:user) { create(:user) }

    before do
      login(user)
    end

    it "returns success response" do
      delete "/sessions/#{user.id}"

      expect(response).to have_http_status(:found)
      expect(response.body).to include(new_session_url)

      expect(cookies[:user_id]).to be_blank
    end
  end

  it_behaves_like "unauthenticated user request", :delete, "/sessions/1"
end
