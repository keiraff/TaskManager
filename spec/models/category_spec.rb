# frozen_string_literal: true

RSpec.describe Category, type: :model do
  subject { build(:category) }

  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }

    it {
      is_expected.to validate_uniqueness_of(:name).case_insensitive.scoped_to(:user_id)
                                                  .with_message("Category already exists.")
    }
  end
end