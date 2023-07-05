# frozen_string_literal: true

RSpec.describe Event, type: :model do
  subject(:event) { build(:event) }

  describe "associations" do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:starts_at) }
    it { is_expected.not_to allow_values(Time.current.yesterday).for(:starts_at) }
    it { is_expected.to allow_values(Time.current.tomorrow).for(:starts_at) }

    it { expect(event.all_day).to be(true) }

    context "with end time" do
      subject(:event) { build(:event, :not_all_day_event) }

      it { expect(event.all_day).to be(false) }

      it { is_expected.not_to allow_values(event.starts_at.yesterday).for(:ends_at) }
      it { is_expected.to allow_values(event.starts_at.tomorrow).for(:ends_at) }
    end
  end
end
