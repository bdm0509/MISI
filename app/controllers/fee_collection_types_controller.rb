class FeeCollectionTypesController < ApplicationController
  
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
    @fee_collection_type = FeeCollectionType.new(fee_collection_type_params)
    if @fee_collection_type.save
      flash[:success] = "The fee collection type #{@fee_collection_type.description} has been created."
      redirect_to :controller => 'fee_collection_types', :action => 'index', :id => @fee_collection_type.id
    else
      @title = "Create New Fee Collection Type"
      render 'new'
    end
  end
  
  def update
    @fee_collection_type = FeeCollectionType.find(params[:id])
    if @fee_collection_type.update_attributes(fee_collection_type_params)
      flash[:success] = "The fee collection type #{@fee_collection_type.description} has been updated."
      redirect_to :controller => 'fee_collection_types', :action => 'index', :id => @fee_collection_type.id
    else
      @title = @fee_collection_type.description
      render 'show'
    end
  end
  
  def destroy
    @fee_collection_type = FeeCollectionType.find(params[:id])
    if @fee_collection_type.destroy
      flash[:success] = "The fee collection type #{@fee_collection_type.description} has been deleted."
    else
      flash[:error] = "Error deleting fee collection type: #{@fee_collection_type.errors}"
    end
    
    redirect_to :controller => 'fee_collection_types', :action => 'index'
  end
  
  private
    def fee_collection_type_params
      params.require(:fee_collection_type).permit(:type, :description)
    end
end
