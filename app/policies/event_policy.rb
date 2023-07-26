# frozen_string_literal: true

class EventPolicy < ApplicationPolicy
  def update?
    !expired?
  end

  private

  def expired?
    record.starts_at < Time.current
  end
end
