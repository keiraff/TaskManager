# frozen_string_literal: true

RSpec.describe Users::Show do
  subject(:service) { described_class.call(user, params) }

  context "with valid params" do
    let(:user) { create(:user) }
    let(:category) { create(:category, user: user) }
    let(:params) { { time: Time.current } }

    let(:today_all_day_event) { create(:event, user: user, category: category, starts_at: Time.current) }
    let(:current_event) do
      build(:event, user: user, category: category, all_day: false, starts_at: 1.day.ago, ends_at: 1.day.from_now)
    end
    let(:tomorrow_event) { create(:event, user: user, category: category, starts_at: 1.day.from_now) }

    before do
      today_all_day_event
      current_event.save(validate: false)
      tomorrow_event
    end

    it "returns success" do
      expect(service.success?).to be(true)

      expect(service.value[:current_events].to_a).to eq([current_event])
      expect(service.value[:today_all_day_events].to_a).to eq([today_all_day_event])
      expect(service.value).not_to include(tomorrow_event)
    end
  end
end
