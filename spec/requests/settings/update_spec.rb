# frozen_string_literal: true

RSpec.describe "PATCH /settings/:id", type: :request do
  subject(:request) { patch "/settings/#{user.id}", params: { user: attributes } }

  context "when user authenticated" do
    let(:user) { create(:user) }

    before do
      login(user)

      request
    end

    context "with valid params" do
      let(:attributes) do
        {
          time_zone: "Eastern Time (US & Canada)",
        }
      end

      it "returns success response" do
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to "/users/#{user.id}"

        expect(User.first).to have_attributes(attributes)

        expect(flash[:success]).to be_present
      end
    end

    context "with invalid params" do
      let(:attributes) do
        {
          time_zone: nil,
        }
      end

      it "returns error" do
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Select your time zone")

        expect(flash[:danger]).to be_present
      end
    end
  end

  it_behaves_like "unauthenticated user request", :patch, "/settings/1"
end
