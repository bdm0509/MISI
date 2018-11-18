class PagesController < ApplicationController
  
  def home
  end
  
  def message
    flash[:notice] = params[:message]
    redirect_to home_path
  end
end
