class EventsController < ApplicationController
  def create
    @collection = Collection.find(params[:collection_id])
    @event = Event.new(event_params)
    if @event.save
      # Trigger Turbo Stream to update the front-end
      broadcast_event_to_frontend(@event)
      redirect_to collection_path(@collection) # Or handle redirection based on your requirements
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:event_type, :property_name, :url, :collection_name, :collection_url, :user_first_name, :user_last_name)
  end

  def broadcast_event_to_frontend(event)
    # Turbo stream broadcasting to append new event to front-end
    turbo_stream.append "recent-activity-list", partial: "events/event", locals: { event: event }
  end
end
