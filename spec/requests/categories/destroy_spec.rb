# frozen_string_literal: true

RSpec.describe "DELETE /categories/:id", type: :request do
  subject(:request) { delete "/categories/#{user.categories[0].id}" }

  context "when user authenticated" do
    let(:user) { create(:user, :with_categories) }

    before do
      login(user)
    end

    it "returns success response" do
      expect { request }.to change(Category, :count).by(-1)

      expect(response).to have_http_status(:found)
      expect(response.body).to redirect_to("/categories")
    end
  end

  it_behaves_like "unauthenticated user request", :delete, "/categories/1"
end
