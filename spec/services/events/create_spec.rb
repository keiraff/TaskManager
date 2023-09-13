# frozen_string_literal: true

RSpec.describe Events::Create do
  subject(:service) { described_class.new(user, event_attributes) }

  let(:user) { create(:user) }
  let(:category) { create(:category, user: user) }

  before do
    service.call
  end

  context "with valid params" do
    let(:event_attributes) do
      {
        name: "New Event",
        all_day: true,
        starts_at: 1.day.from_now,
        category_id: category.id,
      }
    end

    it "returns success" do
      expect(service.success?).to be(true)
      expect(service.value.class).to be(Event)

      expect(user.events.last).to have_attributes(event_attributes.except(:starts_at))
      expect(user.events.last.starts_at.to_s).to eq(event_attributes[:starts_at].to_s)
    end
  end

  context "with invalid params" do
    let(:event_attributes) do
      {
        name: nil,
        all_day: nil,
        starts_at: nil,
        category_id: nil,
      }
    end

    it "returns failure" do
      expect(service.errors?).to be(true)
      expect(service.errors).to eq(user.events.last.errors.full_messages)
    end
  end
end
