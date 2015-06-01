class InvitesController < ApplicationController
 def create
    @event = Event.find(params[:invite][:attended_event_id])
    current_user.attend!(@event)
    flash[:info] = "Will attend #{@event.title}!"
    redirect_to @event
  end

  def destroy
    @event = Invite.find(params[:id]).attended_event
    current_user.cancel!(@event)
    flash[:warning] = "Will not attend #{@event.title}!"
    redirect_to @event
  end

end
