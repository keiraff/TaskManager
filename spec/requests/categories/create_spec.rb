# frozen_string_literal: true

RSpec.describe "POST /categories", type: :request do
  subject(:request) { post "/categories", params: { category: attributes } }

  let(:user) { create(:user) }

  before do
    login(user)
  end

  context "with valid params" do
    let(:attributes) do
      {
        name: "New Category",
      }
    end

    it "returns success response" do
      expect { request }.to change(Category, :count).by(1)

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to "/categories"

      expect(Category.last).to have_attributes(attributes)

      expect(flash[:success]).to be_present
    end
  end

  context "with invalid params" do
    let(:attributes) do
      {
        name: nil,
      }
    end

    it "returns error" do
      expect { request }.not_to change(Category, :count)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("New Category")

      expect(flash[:error]).to be_present
    end
  end
end
