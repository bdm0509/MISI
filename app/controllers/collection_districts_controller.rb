class CollectionDistrictsController < ApplicationController
  
  def index
    @title = "Collection Districts"
    @collection_districts = CollectionDistrict.all
    @new_collection_district_id = params[:id]
  end
  
  def show
    @collection_district = CollectionDistrict.find(params[:id])
    @title = @collection_district.name
  end
  
  def new
    @title = "Create Collection District"
    @collection_district = CollectionDistrict.new
  end
  
  def create
    @collection_district = CollectionDistrict.new(collection_district_params)
    if @collection_district.save
      flash[:success] = "The collection district #{@collection_district.name} has been created."
      redirect_to :controller => 'collection_districts', :action => 'index', :id => @collection_district.id
    else
      @title = "Create New Collection District"
      render 'new'
    end
  end
  
  def update
    @collection_district = CollectionDistrict.find(params[:id])
    if @collection_district.update_attributes(collection_district_params)
      flash[:success] = "The collection district #{@collection_district.name} has been updated."
      redirect_to :controller => 'collection_districts', :action => 'index', :id => @collection_district.id
    else
      @title = @collection_district.name
      render 'show'
    end
  end
  
  def destroy
    @collection_district = CollectionDistrict.find(params[:id])
    if @collection_district.destroy
      flash[:success] = "The collection district #{@collection_district.name} has been deleted."
    else
      flash[:error] = "Error deleting collection district: #{@collection_district.errors}"
    end
    
    redirect_to :controller => 'collection_districts', :action => 'index'
  end
  
  private
    def collection_district_params
      params.require(:collection_district).permit(:name)
    end
end
