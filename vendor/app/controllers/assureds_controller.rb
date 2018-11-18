class AssuredsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @title = "Assureds Listings"
    @assureds = Assured.all
    @new_assured_id = params[:id]
  end
  
  def show
    @assured = Assured.find(params[:id])
    @title = @assured.title
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def new
    @title = "Create New Assured"
    @assured = Assured.new
    @assured.fee ||= Assured::DEFAULT_FEE
  end
  
  def create
    @assured = Assured.new(params[:assured])
    if @assured.save
      redirect_to :controller => 'assureds', :action => 'index', :id => @assured.id
    else
      @title = "Create New Assured"
      render 'new'
    end
  end
  
  def destroy
    @assured = Assured.find(params[:id])
    if @assured.destroy
      flash[:success] = "Assured deleted."
    else
      flash[:error] = "Error deleting assured: #{@assured.errors}"
    end
    
    redirect_to :controller => 'assureds', :action => 'index'
  end
  
  def update
    @assured = Assured.find(params[:id])
    if @assured.update_attributes(params[:assured])
      flash[:success] = "Assured updated."
      redirect_to @assured
    else
      @title = @assured.title
      render 'show'
    end
  end
end