# frozen_string_literal: true

RSpec.describe Event, type: :model do
  subject { build(:event) }

  describe "associations" do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:scheduled_at) }
    it { is_expected.not_to allow_values(Time.zone.yesterday).for(:scheduled_at) }
    it { is_expected.to allow_values(Time.zone.tomorrow).for(:scheduled_at) }
  end
end
