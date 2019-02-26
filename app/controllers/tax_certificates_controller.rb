class TaxCertificatesController < ApplicationController
  require 'pdfcrowd'
  
  def new
    @title = "Create New Tax Certificate"
    @tax_certificate = TaxCertificate.new
  end
  
  def index
    @title = "Tax Certificate Listings"
    @new_tax_certificate_id = params[:id]
    
    # Convert string flag to a boolean
    show_archived = params[:show_archived]
    archive_flag = show_archived == 'true' || false
    @showing_archived = false
    @showing_archived = true if archive_flag == true || archive_flag =~ (/(true|t|yes|y|1)$/i)
    
    if @showing_archived
      @tax_certificates = TaxCertificate.limit(100)
    else
      @tax_certificates = TaxCertificate.where(archived: @showing_archived).limit(100)
    end
    @new_tax_certificate_id = params[:id]
    
    respond_to do |format|
      format.html
      #format.json { render json: MaintenanceOrdersDatatable.new(view_context, @showing_archived) }
    end
  end
  
  def create
    puts tax_certificate_params
    
    @tax_certificate = TaxCertificate.new(tax_certificate_params)
    
    if @tax_certificate.save
      flash[:success] = "The tax certificate #{@tax_certificate.gf} has been created."
      # redirect_to :controller => 'tax_certificates', :action => 'index', :id => @tax_certificate.id
      redirect_to @tax_certificate
    else
      @title = "Create New Tax Certificate"
      render 'new'
    end
  end
  
  def show
    @tax_certificate = TaxCertificate.find(params[:id])
    @title = "Tax Certificate (#{@tax_certificate.gf})"
  end
  
  def update
    @tax_certificate = TaxCertificate.find(params[:id])
    if @tax_certificate.update_attributes(tax_certificate_params)
      flash[:success] = "The tax certificate #{@tax_certificate.gf} has been updated."
      redirect_to @tax_certificate
    else
      @title = "Tax Certificate (#{@tax_certificate.gf})"
      render 'show'
    end
  end
  
  def destroy
    @tax_certificate = TaxCertificate.find(params[:id])
    if @tax_certificate.destroy
      flash[:success] = "The tax certificate #{@tax_certificate.gf} has been deleted."
    else
      flash[:error] = "Error deleting tax certificate: #{@tax_certificate.gf}"
    end
    
    redirect_to :controller => 'tax_certificates', :action => 'index'
  end
  
  private
    def tax_certificate_params
      params.require(:tax_certificate).permit(:gf,
                                              :certificate, 
                                              :title_company,
                                              :order_no)
    end
end