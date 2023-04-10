# frozen_string_literal: true

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe "permit user params" do
    it do
      params = { user: { first_name: user.first_name, last_name: user.last_name, email: user.email,
                         password: user.password, password_confirmation: user.password } }
      is_expected.to permit(:first_name, :last_name, :email, :password, :password_confirmation)
        .for(:create, params: params)
        .on(:user)
    end
  end
end
