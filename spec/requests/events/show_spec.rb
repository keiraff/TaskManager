# frozen_string_literal: true

RSpec.describe "GET /events/:id", type: :request do
  context "when user authenticated" do
    let(:user) { create(:user) }
    let(:category) { create(:category, user: user) }
    let(:event) { create(:event, user: user, category: category) }

    before do
      login(user)
    end

    it "returns success responce" do
      get "/events/#{event.id}"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(event.name, event.description)
    end
  end

  it_behaves_like "unauthenticated user request", :get, "/events/1"
end
