# frozen_string_literal: true

class EventsController < AuthenticatedController
  def index
    @search_result = events_scope.ransack(params[:query])
    @search_result.sorts = ["starts_at asc"] if @search_result.sorts.empty?
    @pagy, @events = pagy(@search_result.result.includes(:category))
  end

  def show
    @event = event
  end

  private

  def event
    @event ||= events_scope.find(params[:id])
  end

  def events_scope
    current_user.events
  end
end
