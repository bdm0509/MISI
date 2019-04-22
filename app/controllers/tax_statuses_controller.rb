class TaxStatusesController < ApplicationController
  
  def index
    @title = "Tax Statuses"
    @tax_statuses = TaxStatus.all
    @new_tax_status_id = params[:id]
  end
  
  def show
    @tax_status = TaxStatus.find(params[:id])
    @title = @tax_status.description
  end
  
  def new
    @title = "Create New Tax Status"
    @tax_status = TaxStatus.new
  end
  
  def create
    @tax_status = TaxStatus.new(tax_status_params)
    if @tax_status.save
      flash[:success] = "The tax status #{@tax_status.description} has been created."
      redirect_to :controller => 'tax_statuses', :action => 'index', :id => @tax_status.id
    else
      @title = "Create New Tax Status"
      render 'new'
    end
  end
  
  def update
    @tax_status = TaxStatus.find(params[:id])
    if @tax_status.update_attributes(tax_status_params)
      flash[:success] = "The tax status #{@tax_status.description} has been updated."
      redirect_to :controller => 'tax_statuses', :action => 'index', :id => @tax_status.id
    else
      @title = @tax_status.description
      render 'show'
    end
  end
  
  def destroy
    @tax_status = TaxStatus.find(params[:id])
    if @tax_status.destroy
      flash[:success] = "The tax status #{@tax_status.description} has been deleted."
    else
      flash[:error] = "Error deleting tax status: #{@tax_status.errors}"
    end
    
    redirect_to :controller => 'tax_statuses', :action => 'index'
  end
  
  private
    def tax_status_params
      params.require(:tax_status).permit(:status, :description)
    end
end
