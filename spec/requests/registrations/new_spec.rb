# frozen_string_literal: true

RSpec.describe "GET registrations/new", type: :request do
  it "returns status code 200" do
    get new_registration_url

    expect(response).to have_http_status(:ok)
  end
end
