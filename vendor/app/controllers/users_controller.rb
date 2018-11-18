class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @user = User.find(params[:id])
  end
  
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
