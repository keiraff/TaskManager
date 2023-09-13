# frozen_string_literal: true

require "sidekiq/web"

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://task-manager-development-redis:6379/0" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://task-manager-development-redis:6379/0" }
end