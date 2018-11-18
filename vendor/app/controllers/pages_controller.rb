class PagesController < ApplicationController

  def home
    @title = "Home"
    begin
      @welcome_text = TextBlock.find_by_name(APP_CONFIG['home_page_text_key']).text_block
    rescue Exception => exc
      @welcome_text = "Welcome"
    end
  end
  
  def message
    flash[:notice] = params[:message]
    redirect_to home_path
  end
end