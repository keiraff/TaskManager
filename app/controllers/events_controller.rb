# frozen_string_literal: true

class EventsController < AuthenticatedController
  def index
    @search_result = events_scope.ransack(params[:query])
    @search_result.sorts = ["starts_at asc"] if @search_result.sorts.empty?
    @pagy, @events = pagy(@search_result.result)
  end

  def show
    event

    result = Events::WeatherUrlService.call(current_user, event)

    if result.success?
      @external_api_url = result.value
    else
      @request_error = result.errors
    end
  end

  def new
    @event = events_scope.new
  end

  def edit
    authorize event
  end

  def create
    result = Events::Create.call(current_user, event_params)

    @event = result.value
    if result.success?
      flash[:success] = "Event created!"
      redirect_to @event
    else
      flash.now[:danger] = "Something went wrong :("
      render "new"
    end
  end

  def update
    authorize event

    result = Events::Update.call(current_user, event, event_params)

    @event = result.value
    if result.success?
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

  def weather_info
    result = Events::WeatherApiJsonResponseParser.call(event, params[:data])

    if result.success?
      @weather = result.value
    else
      @json_parse_error = result.errors
    end
    render layout: false
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
