# frozen_string_literal: true

RSpec.shared_examples "authenticated user request" do |verb, path, string|
  context "when user authenticated" do
    let(:user) { create(:user) }

    before do
      login(user)
    end

    it "returns success responce" do
      public_send verb, path

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("text/html; charset=utf-8")
      expect(response.body).to include(string)
    end
  end
end
