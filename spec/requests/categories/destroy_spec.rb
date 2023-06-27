# frozen_string_literal: true

RSpec.describe "DELETE /categories/:id", type: :request do
  subject(:request) { delete "/categories/#{category.id}" }

  context "when user authenticated" do
    let(:user) { create(:user) }
    let(:category) { create(:category, user: user) }

    before do
      login(user)

      category
    end

    it "returns success response" do
      expect { request }.to change(user.categories, :count).by(-1)

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to "/categories"
    end
  end

  it_behaves_like "unauthenticated user request", :delete, "/categories/1"
end
