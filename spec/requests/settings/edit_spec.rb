# frozen_string_literal: true

RSpec.describe "GET /settings/:id/edit", type: :request do
  context "when user authenticated" do
    let(:user) { create(:user) }

    before do
      login(user)
    end

    it "returns success responce" do
      get "/settings/#{user.id}/edit"

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("text/html; charset=utf-8")
      expect(response.body).to include("Select your time zone")
    end
  end

  it_behaves_like "unauthenticated user request", :get, "/settings/1/edit"
end
