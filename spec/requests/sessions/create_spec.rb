# frozen_string_literal: true

RSpec.describe "POST /sessions", type: :request do
  subject(:request) { post "/sessions", params: attributes }

  let(:user) { create(:user) }

  before { request }

  context "with valid params" do
    let(:attributes) do
      {
        email: user.email,
        password: user.password,
      }
    end

    it "returns success response" do
      expect(response).to have_http_status(:found)
      expect(response.body).to include(user_url(user.id))
    end
  end

  context "with invalid params" do
    let(:attributes) do
      {
        email: nil,
        password: nil,
      }
    end

    it "returns error" do
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('form action="/sessions"')
    end
  end
end
