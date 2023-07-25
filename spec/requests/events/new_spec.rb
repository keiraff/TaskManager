# frozen_string_literal: true

RSpec.describe "GET /events/new", type: :request do
  context "when user authenticated" do
    let(:user) { create(:user) }

    before do
      login(user)
    end

    it "returns success responce" do
      get "/events/new"

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("text/html; charset=utf-8")
      expect(response.body).to include("New Event")
    end
  end

  it_behaves_like "unauthenticated user request", :get, "/events/new"
end
