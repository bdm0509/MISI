class PagesController < ApplicationController
<<<<<<< HEAD
  def home
=======

  def home
    @title = "Home"
    begin
      @welcome_text = TextBlock.find_by_name(APP_CONFIG['home_page_text_key']).text_block
    rescue Exception => exc
      @welcome_text = "Welcome"
    end
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
  end
  
  def message
    flash[:notice] = params[:message]
    redirect_to home_path
  end
<<<<<<< HEAD
end
=======
end
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
