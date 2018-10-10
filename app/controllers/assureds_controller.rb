class AssuredsController < ApplicationController
  
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
    @assured = Assured.new(assured_params)
    if @assured.save
      flash[:success] = "The assured #{@assured.title} has been created."
      redirect_to :controller => 'assureds', :action => 'index', :id => @assured.id
    else
      @title = "Create New Assured"
      render 'new'
    end
  end
  
  def update
    @assured = Assured.find(params[:id])
    if @assured.update_attributes(assured_params)
      flash[:success] = "The assured #{@assured.title} has been updated."
      redirect_to :controller => 'assureds', :action => 'index', :id => @assured.id
    else
      @title = @assured.title
      render 'show'
    end
  end
  
  def destroy
    @assured = Assured.find(params[:id])
    if @assured.destroy
      flash[:success] = "The assured #{@assured.title} has been deleted."
    else
      flash[:error] = "Error deleting assured: #{@assured.errors}"
    end
    
    redirect_to :controller => 'assureds', :action => 'index'
  end
  
  private
    def assured_params
      params.require(:assured).permit(:title, :street, :city, 
                                      :state, :zip, :contact, :phone,
                                      :fee)
    end
  
end