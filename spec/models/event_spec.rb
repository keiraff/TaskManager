# frozen_string_literal: true

RSpec.describe Event, type: :model do
  subject { build(:event) }

  describe "associations" do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:starts_at) }
    it { is_expected.not_to allow_values(1.minute.ago).for(:starts_at) }
    it { is_expected.to allow_values(1.minute.from_now).for(:starts_at) }

    it { is_expected.to allow_values(nil, 1.minute.from_now).for(:notify_at) }
    it { is_expected.not_to allow_values(1.minute.ago).for(:notify_at) }

    context "with all day" do
      it { is_expected.to validate_absence_of(:ends_at) }
    end

    context "without all day" do
      subject(:event) { build(:event, :not_all_day) }

      it { is_expected.to validate_presence_of(:ends_at) }
      it { is_expected.not_to allow_values(event.starts_at.yesterday).for(:ends_at) }
      it { is_expected.to allow_values(event.starts_at.tomorrow).for(:ends_at) }
    end
  end
end
