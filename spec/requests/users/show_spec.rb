# frozen_string_literal: true

RSpec.describe "GET /users/:id", type: :request do
  context "when user authenticated" do
    let(:user) { create(:user) }

    let(:category) { create(:category, name: "Personal", user: user) }

    let(:first_all_day_event) do
      create(:event, name: "Holiday #1", user: user, category: category, starts_at: Time.current)
    end
    let(:second_all_day_event) do
      create(:event, name: "Holiday #2", user: user, category: category, starts_at: Time.current)
    end

    let(:first_current_event) do
      create(:event, :not_all_day, name: "Current Event #1", user: user, category: category, starts_at: Time.current)
    end
    let(:second_current_event) do
      create(:event, :not_all_day, name: "Current Event #2", user: user, category: category, starts_at: Time.current)
    end

    before do
      login(user)

      category

      first_all_day_event
      second_all_day_event

      first_current_event
      second_current_event
    end

    it "returns success responce" do
      get "/users/#{user.id}", params: { today_all_day_events_page: 2, current_events_page: 2, per_page: 1 }

      expect(response).to have_http_status(:ok)

      expect(response.body).to include("Displaying items <b>2-2</b> of <b>2</b> in total").twice
      expect(response.body).to include("Welcome to the page", "Holiday #2", "Current Event #2")
      expect(response.body).not_to include("Holiday #1", "Current Event #1")
    end
  end

  it_behaves_like "unauthenticated user request", :get, "/users/1"
end
