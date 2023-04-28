# frozen_string_literal: true

RSpec.shared_examples "unauthenticated user request" do |verb, path|
  context "when user not authenticated" do
    it "redirects to login" do
      public_send verb, path

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to "/sessions/new"
    end
  end
end
