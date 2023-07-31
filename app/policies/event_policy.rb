# frozen_string_literal: true

class EventPolicy < ApplicationPolicy
  def update?
    self.error_message = "Editing past events isn't allowed."
    !happened?
  end

  private

  def happened?
    if record.all_day?
      record.starts_at.to_date < Time.zone.today
    else
      record.ends_at <= Time.current
    end
  end
end
