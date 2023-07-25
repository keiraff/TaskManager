# frozen_string_literal: true

RSpec.describe "PATCH /categories/:id", type: :request do
  subject(:request) { patch "/categories/#{category.id}", params: { category: attributes } }

  context "when user authenticated" do
    let(:user) { create(:user) }
    let(:category) { create(:category, user: user) }

    before do
      login(user)

      request
    end

    context "with valid params" do
      let(:attributes) do
        {
          name: "Updated category",
        }
      end

      it "returns success response" do
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to "/categories"

        expect(user.categories.first).to have_attributes(attributes)

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
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Edit Category")

        expect(flash[:danger]).to be_present
      end
    end
  end

  it_behaves_like "unauthenticated user request", :patch, "/categories/1"
end
