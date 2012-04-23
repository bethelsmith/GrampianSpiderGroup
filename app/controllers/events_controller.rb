class EventsController < ApplicationController
  
  def index
    @events = Event.paginate(:page => params[:page])
    @title = "All Events"
  end

  def new
    @event = Event.new
    @title = "New Event"
  end
  
  def show
    @event = Event.find(params[:id])
    @title = @event.location_name
  end
  
  def edit
    @event = Event.find(params[:id])
  end
  
  def create
    @event = Event.new(params[:event])
    
    respond_to do |format|
      if @event.save
        format.html { redirect_to(@event, :notice => 'Event was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def upate
    @event = Event.find(params[:id])
    
    respond_to do |format|
      if @event.save
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

end
