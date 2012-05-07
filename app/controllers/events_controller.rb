class EventsController < ApplicationController
  before_filter :authenticate, :except => [:show, :create]
  before_filter :admin_user,   :only => [:new, :edit, :update, :destroy]
  
  def index
    @search = Event.search do
      fulltext params[:search]
      paginate(:page => params[:page])
    end
    @events = @search.results
    @title = "All Events"
    @json = Event.all.to_gmaps4rails
  end

  def new
    @event = Event.new
    @title = "New Event"
  end
  
  def show
    @event = Event.find(params[:id])
    @title = @event.location_name
    @json = @event.to_gmaps4rails
  end
  
  def edit
    @event = Event.find(params[:id])
    @title = "Edit Event"
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
  
  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      flash[:success] = "Event was successfully updated."
      redirect_to @event
    else
      @title = "Edit Event"
      render 'edit'
    end
  end
  
  def destroy
    Event.find(params[:id]).destroy
    flash[:success] = "Event was successfully removed."
    redirect_to events_path
  end
  
  def attendees
    @title = "Attendees"
    @event = Event.find(params[:id])
    @users = @event.attendees.paginate(:page => params[:page])
    render 'show_attendees'
  end
  
  private
  
  def authenticate
    deny_access unless signed_in?
  end
  
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
  
end
