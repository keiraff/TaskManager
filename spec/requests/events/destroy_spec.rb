# frozen_string_literal: true

RSpec.describe "DELETE /events/:id", type: :request do
  subject(:request) { delete "/events/#{event.id}" }

  context "when user authenticated" do
    let(:user) { create(:user) }
    let(:category) { create(:category, user: user) }
    let(:event) { create(:event, user: user, category: category) }

    before do
      login(user)

      category
      event
    end

    it "returns success response" do
      expect { request }.to change(user.events, :count).by(-1)

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to "/events"
    end
  end

  it_behaves_like "unauthenticated user request", :delete, "/events/1"
end
