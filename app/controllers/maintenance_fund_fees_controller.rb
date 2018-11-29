class MaintenanceFundFeesController < ApplicationController
  
  def create
    @maintenance_fund_fee = update_maintenance_fund_fee(nil, 
                                                        params[:maintenance_fund_fee_year], 
                                                        params[:maintenance_fund_fee_amount],
                                                        params[:maintenance_fund_fee][:fee_collection_type_id])
    @maintenance_fund_fee.maintenance_fund = MaintenanceFund.find(params[:maintenance_fund_id])
    
    if @maintenance_fund_fee.save
      @maintenance_fund = @maintenance_fund_fee.maintenance_fund
    else
      @errors = @maintenance_fund_fee.errors
    end
    
    render "update"   
  end
  
  def update
    @maintenance_fund_fee = update_maintenance_fund_fee(params[:id], 
                                                        params[:maintenance_fund_fee_year], 
                                                        params[:maintenance_fund_fee_amount],
                                                        params[:maintenance_fund_fee][:fee_collection_type_id])

    if @maintenance_fund_fee.save
      @maintenance_fund = @maintenance_fund_fee.maintenance_fund
    else
      @errors = @maintenance_fund_fee.errors
    end
    
    respond_to { |format|
      format.js
    }
  end
  
private
  def update_maintenance_fund_fee(id, year, amount, fee_collection_type_id)
    if id.nil?
      maintenance_fund_fee = MaintenanceFundFee.new
    else
      maintenance_fund_fee = MaintenanceFundFee.find(id)
    end
    
    maintenance_fund_fee.year = year
    maintenance_fund_fee.amount = amount
    begin
      maintenance_fund_fee.fee_collection_type =  FeeCollectionType.find(fee_collection_type_id)
    rescue ActiveRecord::RecordNotFound => exc
      # Don't update the maintenance fund fee
    end
    
    maintenance_fund_fee
  end
end