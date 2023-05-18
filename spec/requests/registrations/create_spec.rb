# frozen_string_literal: true

RSpec.describe "POST /registrations", type: :request do
  subject(:request) { post "/registrations", params: { user: attributes } }

  context "with valid params" do
    let(:attributes) do
      {
        first_name: "Foe",
        last_name: "Bar",
        email: "test@example.com",
        password: "qwerty",
        password_confirmation: "qwerty",
      }
    end

    it "returns success response" do
      expect { request }.to change(User, :count).by(1)

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to("/users/#{User.last.id}")

      expect(User.last).to have_attributes(attributes.except(:password, :password_confirmation))
    end
  end

  context "with invalid params" do
    let(:attributes) do
      {
        first_name: nil,
        last_name: nil,
        email: nil,
        password: nil,
        password_confirmation: nil,
      }
    end

    it "returns error" do
      expect { request }.not_to change(User, :count)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(registrations_url)
    end
  end
end
