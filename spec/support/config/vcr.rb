# frozen_string_literal: true

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!

  config.default_cassette_options = {
    allow_unused_http_interactions: false,
    match_requests_on: [:uri, :headers, :method, :body],
  }

  config.before_record do |interaction|
    interaction.response.body.force_encoding("UTF-8")
  end
end
