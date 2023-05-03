# frozen_string_literal: true

class ApplicationService
  attr_reader :value, :errors

  def success?
    !errors?
  end

  def errors?
    errors.present?
  end

  def success(value)
    self.value = value
  end

  def failure(value)
    self.value = value
    self.errors = value.errors
  end

  def self.call(*args)
    service = new(*args)

    service.call
    service
  end

  private

  attr_writer :value, :errors
end
