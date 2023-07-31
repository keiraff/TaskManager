# frozen_string_literal: true

class EventsQuery
  class << self
    def call(scope, filters)
      scope = filter_by_date(scope, filters[:current_date]) if filters[:current_date].present?
      scope = filter_by_time(scope, filters[:current_time]) if filters[:current_time].present?
      scope
    end

    private

    # Find all-day events on specific date
    def filter_by_date(scope, date)
      return scope if date.blank?

      scope.where("DATE(starts_at) = ?", date).where(all_day: true)
    end

    # Find active non-all-day events at specific time
    def filter_by_time(scope, time)
      return scope if time.blank?

      scope.where("starts_at < ?", time).where("ends_at > ?", time)
    end
  end
end
