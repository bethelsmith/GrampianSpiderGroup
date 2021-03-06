class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  
  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def index
    @search = User.search do
      fulltext params[:search]
      paginate(:page => params[:page])
    end
    @users = @search.results
    @title = "All users"
  end
  
  def show
    @user = User.find(params[:id])
    @records = @user.records.paginate(:page => params[:page])
    @title = @user.name
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.welcome_email(@user).deliver
      sign_in @user
      flash[:success] = "Welcome to the Grampian Spider Group!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end
  
  def edit
    @title = "Edit user"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end
  
  def attending
    @title = "Attending"
    @user = User.find(params[:id])
    @events = @user.attending.paginate(:page => params[:page])
    render 'show_attending'
  end
  
  def records
    @title = "Records"
    @user = User.find(params[:id])
    @records = @user.records.paginate(:page => params[:page])
    render 'show_records'
  end

  private
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
  
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
    
end
