# frozen_string_literal: true

RSpec.describe "GET /users/:id", type: :request do
  it_behaves_like "authenticated user request", :get, "/users/1", "Welcome to the page"

  it_behaves_like "unauthenticated user request", :get, "/users/1"
end
