# frozen_string_literal: true

RSpec.describe "GET /events/:id/edit", type: :request do
  context "when user authenticated" do
    let(:user) { create(:user) }
    let(:category) { create(:category, user: user) }

    before do
      login(user)

      category
    end

    context "when future event" do
      let(:event) { create(:event, user: user, category: category) }

      it "returns success responce" do
        get "/events/#{event.id}/edit"

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("text/html; charset=utf-8")
        expect(response.body).to include("Edit Event")
      end
    end

    context "when past event" do
      let(:event) { create(:event, starts_at: Time.current, user: user, category: category) }

      it "redirects to events page" do
        get "/events/#{event.id}/edit"

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to "/events"

        expect(flash[:danger]).to match(/Editing past events isn't allowed./)
      end
    end
  end

  it_behaves_like "unauthenticated user request", :get, "/events/1/edit"
end
