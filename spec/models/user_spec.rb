# frozen_string_literal: true

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { is_expected.to have_secure_password }

  describe "associations" do
    it { is_expected.to have_many(:categories).dependent(:restrict_with_exception) }
    it { is_expected.to have_many(:events).dependent(:restrict_with_exception) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.not_to allow_values("@", "2@com", "@mail.com", "gmail").for(:email) }
    it { is_expected.to allow_values("foo@gmail.com").for(:email) }

    it {
      is_expected.to validate_inclusion_of(:time_zone).in_array(ActiveSupport::TimeZone.all.map(&:name))
                                                      .with_message("Time zone is invalid.")
    }
  end

  describe "password validations" do
    context "when user create" do
      subject { build(:user) }

      it { is_expected.to validate_confirmation_of(:password) }
      it { is_expected.to validate_length_of(:password).is_at_least(6) }
    end

    context "when user update" do
      context "with password" do
        subject(:user) { create(:user) }

        before do
          user.password = "12345"
          user.valid?
        end

        it { expect(user.errors["password"]).to include("is too short (minimum is 6 characters)") }
      end

      context "without password" do
        subject(:user) { described_class.find(create(:user).id) }

        it "skips password length validation" do
          expect(user.password).to be_nil
          is_expected.to be_valid
        end
      end
    end
  end
end
