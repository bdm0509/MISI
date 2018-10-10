class MaintenanceFundsController < ApplicationController
  require 'pdfcrowd'
  
  def index
    @title = "Maintenance Funds/Associations Listings"
    @maintenance_funds = MaintenanceFund.all
    @new_maintenance_fund_id = params[:id]
    
    respond_to do |format|
      format.html
      format.json { render json: MaintenanceFundsDatatable.new(view_context) }
    end
  end
  
  def print
    begin
      # create an API client instance
      client = Pdfcrowd::Client.new("misi", "afec1b458239c068061334c4fe8f93a6")
      client.setHorizontalMargin("0.25in")
      client.setVerticalMargin("0.5in")
      client.setHeaderHtml("<div id='print_header' style='text-align: right'><p>MISI HOA Listings - #{Time.now.strftime("%m/%d/%Y")}</p></div>")
      client.setFooterHtml("<div id='print_footer' style='text-align: right'><p>Page %p of %n</p></div>")
      
      @maintenance_funds = MaintenanceFund.find(:all, :order => "name asc", :limit => 15)
      @show_additional_contact_information = params[:show_additional_contact_information].blank? ? false : 
                                               params[:show_additional_contact_information] == "true" ? true : false
                                               
      puts "It's true!" if @show_additional_contact_information
      puts "It's false!" if !@show_additional_contact_information
      
      @printing = true
      
      hoa_listing = render_to_string(
        :partial => "maintenance_funds/print",
        :locals => { 
          :maintenance_funds => @maintenance_funds,
          :hide_additional_contact_info => !@show_additional_contact_information
        }
      )

      # convert a web page and store the generated PDF to a variable
      pdf = client.convertHtml(hoa_listing)

      # send the generated PDF
      send_data(pdf, 
                :filename => "misi_hoa_listings.pdf",
                :type => "application/pdf",
                :disposition => "attachment")
    rescue Pdfcrowd::Error => why
      render :text => why
    end
  end
  
  def show
    @maintenance_fund = MaintenanceFund.find(params[:id])
    @title = @maintenance_fund.name
    
    if @maintenance_fund.maintenance_fund_fees.exists?
      @maintenance_fund_fee_amount = "#{@maintenance_fund.maintenance_fund_fees.order('year DESC').first.amount}"
      @maintenance_fund_fee_year   = "#{@maintenance_fund.maintenance_fund_fees.order('year DESC').first.year}"
    else
      @maintenance_fund_fee_amount = ""
      @maintenance_fund_fee_year   = ""
    end
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def new
    @title = "Create New Maintenance Fund/Association"
    @maintenance_fund = MaintenanceFund.new
  end
  
  def show
    @maintenance_fund = MaintenanceFund.find(params[:id])
    @title = @maintenance_fund.name
    
    if @maintenance_fund.maintenance_fund_fees.exists?
      @maintenance_fund_fee_amount = "#{@maintenance_fund.maintenance_fund_fees.order('year DESC').first.amount}"
      @maintenance_fund_fee_year   = "#{@maintenance_fund.maintenance_fund_fees.order('year DESC').first.year}"
    else
      @maintenance_fund_fee_amount = ""
      @maintenance_fund_fee_year   = ""
    end
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def update
    @maintenance_fund = MaintenanceFund.find(params[:id])
    if @maintenance_fund.update_attributes(maintenance_fund_params)
      flash[:success] = "The maintenance fund/association #{@maintenance_fund.name} has been updated."
      redirect_to @maintenance_fund
    else
      @title = @maintenance_fund.name
      render 'show'
    end
  end
  
  def create
    @maintenance_fund = MaintenanceFund.new(maintenance_fund_params)
    if @maintenance_fund.save
      flash[:success] = "The maintenance fund/association #{@maintenance_fund.name} has been created."
      redirect_to :controller => 'maintenance_funds', :action => 'index', :id => @maintenance_fund.id
    else
      @title = "Create New Maintenance Fund/Association"
      render 'new'
    end
  end
  
  def destroy
    @maintenance_fund = MaintenanceFund.find(params[:id])
    if @maintenance_fund.destroy
      flash[:success] = "The maintenance fund/association #{@maintenance_fund.name} has been deleted."
    else
      flash[:error] = "Error deleting maintenance fund/association: #{@maintenance_fund.errors}"
    end
    
    redirect_to :controller => 'maintenance_funds', :action => 'index'
  end
  
private
  def maintenance_fund_params
    params.require(:maintenance_fund).permit(:name, :collector, :street,
                                             :city, :state, :zip,
                                             :contact, :phone, :fax, :email,
                                             :instructions, :amenities)
  end
end