class TaxEntriesController < ApplicationController
  
  def create
    @tax_entry = update_tax_entry(nil, 
                                  params[:tax_entry][:district_type_id], 
                                  params[:tax_entry][:collection_district_id],
                                  params[:tax_entry_account_number],
                                  params[:tax_entry_year],
                                  params[:tax_entry_base_tax],
                                  params[:tax_entry][:tax_status_id])
                                  
    @tax_entry.tax_certificate = TaxCertificate.find(params[:tax_certificate_id])
    
    if @tax_entry.save
      @tax_certificate = @tax_entry.tax_certificate
    else
      @errors = @tax_entry.errors
    end
    
    render "update"   
  end
  
  def update
    @tax_entry = update_tax_entry(params[:id], 
                                  params[:tax_entry][:district_type_id], 
                                  params[:tax_entry][:collection_district_id],
                                  params[:tax_entry_account_number],
                                  params[:tax_entry_year],
                                  params[:tax_entry_base_tax],
                                  params[:tax_entry][:tax_status_id])

    if @tax_entry.save
      @tax_certificate = @tax_entry.tax_certificate
    else
      @errors = @tax_entry.errors
    end
        
    respond_to { |format|
      format.js
    }
  end
  
private
  def update_tax_entry(id, district_type_id, collection_district_id, 
                       account_number, year, base_tax, tax_status_id)
    if id.nil?
      tax_entry = TaxEntry.new
    else
      tax_entry = TaxEntry.find(id)
    end
    
    tax_entry.account_number = account_number
    tax_entry.year = year
    tax_entry.base_tax = base_tax
    
    begin
      tax_entry.district_type =  DistrictType.find(district_type_id)
    rescue ActiveRecord::RecordNotFound => exc
      puts "ERROR 1"
      # Don't update the tax entry
    end
    begin
      tax_entry.collection_district =  CollectionDistrict.find(collection_district_id)
    rescue ActiveRecord::RecordNotFound => exc
      puts "ERROR 2"
      # Don't update the tax entry
    end
    begin
      tax_entry.tax_status =  TaxStatus.find(tax_status_id)
    rescue ActiveRecord::RecordNotFound => exc
      puts "ERROR 3"
      # Don't update the tax entry
    end
    
    tax_entry
  end
end