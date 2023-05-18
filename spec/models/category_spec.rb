# frozen_string_literal: true

RSpec.describe Category, type: :model do
  subject { build(:category) }

  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }

    context "with user" do
      subject { build(:category, :with_user) }

      it { is_expected.to validate_uniqueness_of(:name).case_insensitive.scoped_to(:user_id) }
    end
  end
end
