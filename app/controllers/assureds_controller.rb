class AssuredsController < ApplicationController
<<<<<<< HEAD
=======
  before_filter :authenticate_user!
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
  
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
<<<<<<< HEAD
    @assured = Assured.new(assured_params)
    if @assured.save
      flash[:success] = "The assured #{@assured.title} has been created."
=======
    @assured = Assured.new(params[:assured])
    if @assured.save
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
      redirect_to :controller => 'assureds', :action => 'index', :id => @assured.id
    else
      @title = "Create New Assured"
      render 'new'
    end
  end
  
<<<<<<< HEAD
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
=======
  def destroy
    @assured = Assured.find(params[:id])
    if @assured.destroy
      flash[:success] = "Assured deleted."
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
    else
      flash[:error] = "Error deleting assured: #{@assured.errors}"
    end
    
    redirect_to :controller => 'assureds', :action => 'index'
  end
  
<<<<<<< HEAD
  private
    def assured_params
      params.require(:assured).permit(:title, :street, :city, 
                                      :state, :zip, :contact, :phone,
                                      :fee)
    end
  
=======
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
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
end