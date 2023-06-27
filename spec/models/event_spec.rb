# frozen_string_literal: true

RSpec.describe Event, type: :model do
  subject { build(:event) }

  describe "associations" do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(100) }

    it { is_expected.to validate_length_of(:description).is_at_most(1000) }

    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.not_to allow_values(Time.zone.yesterday).for(:date) }
    it { is_expected.to allow_values(Time.zone.tomorrow).for(:date) }
  end
end
