# frozen_string_literal: true

RSpec.describe "PATCH /events/:id", type: :request do
  subject(:request) { patch "/events/#{event.id}", params: { event: attributes } }

  context "when user authenticated" do
    let(:user) { create(:user) }
    let(:category) { create(:category, user: user) }
    let(:event) { create(:event, user: user, category: category) }

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

      before do
        request
      end

      it "returns success response" do
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to "/events/#{event.id}"

        expect(user.events.last).to have_attributes(attributes.except(:starts_at))
        expect(user.events.last.starts_at.to_s).to eq(attributes[:starts_at].to_s)

        expect(flash[:success]).to be_present
      end
    end

    context "with invalid params" do
      let(:attributes) do
        {
          name: nil,
          starts_at: 1.day.ago,
          category_id: nil,
        }
      end

      before do
        request
      end

      it "returns error" do
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Edit Event")

        expect(flash[:danger]).to be_present
      end
    end

    context "when past event" do
      let(:event) do
        create(:event, all_day: false, starts_at: Time.current, ends_at: Time.current, user: user, category: category)
      end

      it "redirects to events page" do
        patch "/events/#{event.id}"

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to "/events"

        expect(flash[:danger]).to match(/Editing past events isn't allowed./)
      end
    end
  end

  it_behaves_like "unauthenticated user request", :patch, "/events/1"
end
