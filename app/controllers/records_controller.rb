class RecordsController < ApplicationController
  before_filter :authenticate, :except => [:show, :create]
  before_filter :authorized_user, :only => [:edit, :update, :destroy]

  def index
    @records= Record.paginate(:page => params[:page]).order( 'created_at DESC')
    @title = "All Records"
  end
  
  def new
    @record = Record.new
    @title = "New Record"
  end
  
  def show
    @record = Record.find(params[:id])
    @title = @record.title
  end
  
  def edit
    @record = Record.find(params[:id])
    @title = "Edit Record"
  end

  def create
    @record  = current_user.records.build(params[:record])
    
    respond_to do |format|
      if @record.save
        format.html { redirect_to(@record, :notice => 'Record was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def update
    @record = Record.find(params[:id])
    
    if @record.update_attributes(params[:record])
      flash[:success] = "Record was successfully updated."
      redirect_to @record
    else
      @title = "Edit Record"
      render 'edit'
    end
  end

  def destroy
    Record.find(params[:id]).destroy
    flash[:success] = "Record was successfully removed."
    redirect_to records_path
  end
  
  private

    def authorized_user
      @record = current_user.records.find_by_id(params[:id])
      redirect_to root_path if @record.nil?
    end
  
end