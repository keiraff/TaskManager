# frozen_string_literal: true

class EventPolicy < ApplicationPolicy
  def update?
    !happened?
  end

  private

  def happened?
    record.starts_at < Time.current
  end
end
