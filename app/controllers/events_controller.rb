# frozen_string_literal: true

class EventsController < AuthenticatedController
  def index
    @search_result = events_scope.ransack(params[:query])
    @search_result.sorts = ["starts_at asc"] if @search_result.sorts.empty?
    @pagy, @events = pagy(@search_result.result)
  end

  def show
    event
  end

  def new
    @event = events_scope.new
  end

  def edit
    authorize event
  end

  def create
    @event = events_scope.new(event_params)

    if @event.save
      flash[:success] = "Event created!"
      redirect_to events_url
    else
      flash.now[:danger] = "Something went wrong :("
      render "new"
    end
  end

  def update
    redirect_to events_url unless authorize event

    if event.update(event_params)
      flash[:success] = "Event updated!"
      redirect_to @event
    else
      flash.now[:danger] = "Something went wrong :("
      render "edit"
    end
  end

  def destroy
    event.destroy

    flash[:success] = "Event deleted!"
    redirect_to events_url
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :all_day, :starts_at, :ends_at, :notify_at, :category_id)
  end

  def event
    @event ||= events_scope.find(params[:id])
  end

  def events_scope
    current_user.events
  end
end
