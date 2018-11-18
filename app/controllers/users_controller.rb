class UsersController < ApplicationController
<<<<<<< HEAD
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
=======
  before_filter :authenticate_user!
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
  
  def show
    @user = User.find(params[:id])
  end
<<<<<<< HEAD

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "The user has been created successfully!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "The requested user was deleted."
    redirect_to users_url
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "You must login before accessing this system."
      redirect_to login_url
    end
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name,
                                   :email, :password,
                                   :password_confirmation)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
=======
  
  def new
    @user = User.new
  end
  
  def edit
    @user = current_user
  end
  
  def edit_password
    @user = current_user
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path, :notice => "User created."
    else
      render :action => 'new'
    end
  end
  
  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      sign_in @user, :bypass => true
      redirect_to root_path, :notice => "Profile updated."
    else
      render :action => 'edit'
    end
  end
  
  def update_password
    @user = User.find(current_user.id)
    if @user.update_with_password(params[:user])
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to root_path, :notice => "Password changed."
    else
      flash[:error] = @user.errors.first.join(' ').gsub /<br>/, ""
      render :action => 'edit_password'
    end
  end
end
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
