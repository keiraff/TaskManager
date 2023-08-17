# frozen_string_literal: true

RSpec.describe "GET /location", type: :request do
  subject(:request) { get "/location", params: attributes, as: :json }

  context "when user authenticated" do
    let(:user) { create(:user) }

    before do
      login(user)

      request
    end

    context "with valid params" do
      let(:attributes) do
        {
          country: "US",
          state: "NY",
        }
      end

      it "returns success responce" do
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response.body).to include(CS.states(attributes[:country]).first[1],
                                         CS.cities(attributes[:state], attributes[:country]).first[1])
      end
    end

    context "with invalid params" do
      let(:attributes) do
        {
          country: nil,
          state: nil,
        }
      end

      it "returns success responce" do
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response.body).to include("{\"states\":null,\"cities\":null}")
      end
    end
  end

  it_behaves_like "unauthenticated user request", :get, "/location"
end
