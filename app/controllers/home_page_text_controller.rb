class HomePageTextController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @title = 'Home Page text updater'
    @text_block = TextBlock.find_by_name(APP_CONFIG['home_page_text_key'])
  end
  
  def update
    @text_block = TextBlock.find_by_name(APP_CONFIG['home_page_text_key'])
    @text_block.text_block = params[:home_page_text]
    if @text_block.save
      flash[:success] = "Home Page text updated and active."
    else
      flash[:error] = "Error updating home page text: #{@text_block.errors}"
    end
    render 'show'
  end
end