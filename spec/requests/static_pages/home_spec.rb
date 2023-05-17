# frozen_string_literal: true

RSpec.describe "GET /", type: :request do
  it "returns status code 200" do
    get "/"

    expect(response).to have_http_status(:ok)
  end
end
