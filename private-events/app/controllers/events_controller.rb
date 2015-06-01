class EventsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_creator, only: [:edit, :update]

  def new
    @event = Event.new
  end

  def index
    #@events = Event.all
    @events_upcoming = Event.upcoming.paginate(page: params[:upcoming])
    @events_past = Event.past.paginate(page: params[:past])
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "New event is created!"
      redirect_to event_path(@event)
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:success] = "Event updated!"
      redirect_to @event
    else
      render 'edit'
    end
  end

  private

    def event_params
      params.require(:event).permit(:title, :description, :date)
    end

    def correct_creator
      @event = Event.find(params[:id])
      redirect_to(root_url) unless current_user == @event.creator
    end
end
