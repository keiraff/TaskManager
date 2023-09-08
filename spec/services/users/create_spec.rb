# frozen_string_literal: true

RSpec.describe Users::Create do
  subject(:service) { described_class.call(user_attributes) }

  context "with valid params" do
    let(:user_attributes) do
      {
        first_name: "Foe",
        last_name: "Bar",
        email: "test@example.com",
        password: "qwerty",
        password_confirmation: "qwerty",
      }
    end

    it "returns success" do
      expect(service.success?).to be(true)
      expect(service.value.class).to be(User)

      expect(User.last).to have_attributes(user_attributes.except(:password, :password_confirmation))
    end
  end

  context "with invalid params" do
    let(:user_attributes) do
      {
        first_name: nil,
        last_name: nil,
        email: nil,
        password: nil,
        password_confirmation: nil,
      }
    end

    it "returns failure" do
      expect(service.errors?).to be(true)
      expect(service.errors).to eq(service.user.errors.full_messages)
    end
  end
end
