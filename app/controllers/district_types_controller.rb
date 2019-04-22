class DistrictTypesController < ApplicationController
  
  def index
    @title = "District Types"
    @district_types = DistrictType.all
    @new_district_type_id = params[:id]
  end
  
  def show
    @district_type = DistrictType.find(params[:id])
    @title = @district_type.description
  end
  
  def new
    @title = "Create New District Type"
    @district_type = DistrictType.new
  end
  
  def create
    @district_type = DistrictType.new(district_type_params)
    if @district_type.save
      flash[:success] = "The distrct type #{@district_type.description} has been created."
      redirect_to :controller => 'district_types', :action => 'index', :id => @district_type.id
    else
      @title = "Create New District Type"
      render 'new'
    end
  end
  
  def update
    @district_type = DistrictType.find(params[:id])
    if @district_type.update_attributes(district_type_params)
      flash[:success] = "The district type #{@district_type.description} has been updated."
      redirect_to :controller => 'district_types', :action => 'index', :id => @district_type.id
    else
      @title = @district_type.description
      render 'show'
    end
  end
  
  def destroy
    @district_type = DistrictType.find(params[:id])
    if @district_type.destroy
      flash[:success] = "The district type #{@district_type.description} has been deleted."
    else
      flash[:error] = "Error deleting district type: #{@district_type.errors}"
    end
    
    redirect_to :controller => 'district_types', :action => 'index'
  end
  
  private
    def district_type_params
      params.require(:district_type).permit(:type, :description)
    end
end
