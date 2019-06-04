class DelinquentTaxEntriesController < ApplicationController
  
  def create
    @delinquent_tax_entry = update_tax_entry(
                                  nil, 
                                  params[:delinquent_tax_entry][:district_type_id],
                                  params[:delinquent_tax_entry_account_number],
                                  params[:delinquent_tax_entry_year_due],
                                  params[:delinquent_tax_entry_amount])
                                  
    @delinquent_tax_entry.tax_certificate =
      DelinquentTaxCertificate.find(params[:delinquent_tax_certificate_id])
    
    if @delinquent_tax_entry.save
      @tax_certificate = @delinquent_tax_entry.tax_certificate
    else
      @errors = @delinquent_tax_entry.errors
    end
    
    render "update"   
  end
  
  def update
    @delinquent_tax_entry = update_delinquent_tax_entry(
                                  params[:id], 
                                  params[:delinquent_tax_entry][:district_type_id],
                                  params[:delinquent_tax_entry_account_number],
                                  params[:delinquent_tax_entry_year_due],
                                  params[:delinquent_tax_entry_amount])

    if @delinquent_tax_entry.save
      @tax_certificate = @delinquent_tax_entry.tax_certificate
    else
      @errors = @delinquent_tax_entry.errors
    end
        
    respond_to { |format|
      format.js
    }
  end
  
private
  def update_delinquent_tax_entry(id, district_type_id, 
                                  account_number, year_due, amount)
    if id.nil?
      delinquent_tax_entry = DelinquentTaxEntry.new
    else
      delinquent_tax_entry = DelinquentTaxEntry.find(id)
    end
    
    delinquent_tax_entry.account_number = account_number
    delinquent_tax_entry.year_due = year_due
    delinquent_tax_entry.amount = amount
    
    begin
      delinquent_tax_entry.district_type =  DistrictType.find(district_type_id)
    rescue ActiveRecord::RecordNotFound => exc
      puts "ERROR 1"
      # Don't update the tax entry
    end
    
    delinquent_tax_entry
  end
end