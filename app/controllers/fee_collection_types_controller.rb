class FeeCollectionTypesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @title = "Fee Collection Types"
    @fee_collection_types = FeeCollectionType.all
    @new_fee_collection_type_id = params[:id]
  end
  
  def show
    @fee_collection_type = FeeCollectionType.find(params[:id])
    @title = @fee_collection_type.description
  end
  
  def new
    @title = "Create New Fee Collection Type"
    @fee_collection_type = FeeCollectionType.new
  end
  
  def create
    @fee_collection_type = FeeCollectionType.new(params[:fee_collection_type])
    if @fee_collection_type.save
      redirect_to :controller => 'fee_collection_types', :action => 'index', :id => @fee_collection_type.id
    else
      @title = "Create New Fee Collection Type"
      render 'new'
    end
  end
  
  def destroy
    @fee_collection_type = FeeCollectionType.find(params[:id])
    if @fee_collection_type.destroy
      flash[:success] = "Fee Collection Type deleted."
    else
      flash[:error] = "Error deleting fee collection type: #{@fee_collection_type.errors}"
    end
    
    redirect_to :controller => 'fee_collection_types', :action => 'index'
  end
  
  def update
    @fee_collection_type = FeeCollectionType.find(params[:id])
    if @fee_collection_type.update_attributes(params[:fee_collection_type])
      flash[:success] = "Fee Collection Type updated."
      redirect_to @fee_collection_type
    else
      @title = @fee_collection_type.description
      render 'show'
    end
  end
end