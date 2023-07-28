# frozen_string_literal: true

class EventPolicy < ApplicationPolicy
  def update?
    self.error_message = "Editing past events isn't allowed."
    !happened?
  end

  private

  def happened?
    record.starts_at < Time.current
  end
end
