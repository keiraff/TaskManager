# frozen_string_literal: true

RSpec.shared_examples "unauthenticated user request" do |path|
  context "when user not authenticated" do
    before do
      request
    end

    it "redirects to #{path}" do
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to path
    end
  end
end
