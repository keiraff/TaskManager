# frozen_string_literal: true

RSpec.describe "GET /users/:id/categories", type: :request do
  it_behaves_like "authenticated user request", :get, "/users/1/categories", "Categories"

  it_behaves_like "unauthenticated user request", :get, "/users/1/categories"
end
