# frozen_string_literal: true

RSpec.describe "POST /events", type: :request do
  subject(:request) { post "/events", params: { event: attributes } }

  let(:user) { create(:user) }
  let(:category) { create(:category, user: user) }

  before do
    login(user)

    category
  end

  context "with valid params" do
    let(:attributes) do
      {
        name: "New Event",
        all_day: true,
        starts_at: 1.day.from_now,
        category_id: category.id,
      }
    end

    it "returns success response" do
      expect { request }.to change(user.events, :count).by(1)

      expect(response).to redirect_to "/events"

      expect(user.events.last).to have_attributes(attributes.except(:starts_at))
      expect(user.events.last.starts_at.utc).to be_within(1.second).of 1.day.from_now

      expect(flash[:success]).to be_present
    end
  end

  context "with invalid params" do
    let(:attributes) do
      {
        name: nil,
        all_day: nil,
        starts_at: nil,
        category_id: nil,
      }
    end

    it "returns error" do
      expect { request }.not_to change(Event, :count)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("New Event")

      expect(flash[:danger]).to be_present
    end
  end
end
