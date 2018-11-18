class MaintenanceFundsController < ApplicationController
  require 'pdfcrowd'
<<<<<<< HEAD
  
  def index
    @title = "Maintenance Funds/Associations Listings"
    @maintenance_funds = MaintenanceFund.all
    @new_maintenance_fund_id = params[:id]
    
    respond_to do |format|
      format.html
      format.json { render json: MaintenanceFundsDatatable.new(view_context) }
    end
=======
  include ApplicationHelper
  before_filter :authenticate_user!
  
  def index
    per_page = 50 if params[:per_page].blank?
    @title = "Maintenance Funds/Associations Listings"
    
    @maintenance_funds = MaintenanceFund.paginate(:page => params[:page], :per_page => per_page)
    @num_maintenance_funds = per_page
    
    @new_maintenance_fund_id = params[:id]
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
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
  
<<<<<<< HEAD
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
  
=======
  def datatable
    @maintenance_funds = current_funds(params)
    @num_maintenance_funds = total_funds(params)
    
    aaData = []
    @maintenance_funds.each do |maintenance_fund|
      aaData << [ 
        self.class.helpers.link_to(maintenance_fund.name, url_for(:controller => "maintenance_funds", :action => "show", :id => maintenance_fund.id)),
        maintenance_fund.collector,
        maintenance_fund.street,
        maintenance_fund.city,
        maintenance_fund.state,
        maintenance_fund.zip,
        "<a href='javascript:maintenance_fund_contact_info(\"#{maintenance_fund.name}\", \"#{maintenance_fund.contact || ""}\", \"#{maintenance_fund.phone || ""}\");'>Contact Information</a>",
        self.class.helpers.link_to("Delete", url_for(:controller => "maintenance_funds", :action => "destroy", :id => maintenance_fund.id), :method => :delete, :confirm => "Are you sure?", :class => "button delete")
      ]
    end
    
    response = {
      :sEcho => params[:sEcho] || -1,
      :iTotalRecords => @num_maintenance_funds,
      :iTotalDisplayRecords => @num_maintenance_funds,
      :aaData => aaData
    }
    Rails.logger.info "Response: #{response.to_json}"
    
    respond_to do |format|
      format.js { render :json => response.to_json }
    end
  end
  
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
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
  
<<<<<<< HEAD
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
=======
  def new
    @title = "Create New Maintenance Fund/Association"
    @maintenance_fund = MaintenanceFund.new
  end
  
  def create
    @maintenance_fund = MaintenanceFund.new(params[:maintenance_fund])
    if @maintenance_fund.save
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
      redirect_to :controller => 'maintenance_funds', :action => 'index', :id => @maintenance_fund.id
    else
      @title = "Create New Maintenance Fund/Association"
      render 'new'
    end
  end
  
  def destroy
    @maintenance_fund = MaintenanceFund.find(params[:id])
    if @maintenance_fund.destroy
<<<<<<< HEAD
      flash[:success] = "The maintenance fund/association #{@maintenance_fund.name} has been deleted."
=======
      flash[:success] = "Maintenance Fund/Association deleted."
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
    else
      flash[:error] = "Error deleting maintenance fund/association: #{@maintenance_fund.errors}"
    end
    
    redirect_to :controller => 'maintenance_funds', :action => 'index'
  end
  
<<<<<<< HEAD
private
  def maintenance_fund_params
    params.require(:maintenance_fund).permit(:name, :collector, :street,
                                             :city, :state, :zip,
                                             :contact, :phone, :fax, :email,
                                             :instructions, :amenities)
=======
  def update
    @maintenance_fund = MaintenanceFund.find(params[:id])
    if @maintenance_fund.update_attributes(params[:maintenance_fund])
      flash[:success] = "Maintenance Fund/Association updated."
      redirect_to @maintenance_fund
    else
      @title = @maintenance_fund.name
      render 'show'
    end
  end
  
  def update_special_characters
    @msg = ""
    MaintenanceFund.where('instructions ILIKE ?', '%&amp;%').each do |hoa|
      @msg += "Replacing special character &amp; in special instructions for HOA '#{hoa.name}'...\n"
      hoa.instructions = hoa.instructions.gsub(/\&amp;/, "&")
      hoa.save!
    end
    MaintenanceFund.where('amenities ILIKE ?', '%&amp;%').each do |hoa|
      @msg += "Replacing special character &amp; in amenities for HOA '#{hoa.name}'...\n"
      hoa.amenities = hoa.amenities.gsub(/\&amp;/, "&")
      hoa.save!
    end
  end
  
private
  def current_funds(params={})
    current_page = (params[:iDisplayStart].to_i/params[:iDisplayLength].to_i rescue 0) + 1
    MaintenanceFund.paginate :page => current_page,
                             :order => "#{datatable_columns(params[:iSortCol_0])} #{params[:sSortDir_0] || "asc"}",
                             :conditions => conditions,
                             :per_page => params[:iDisplayLength]
  end
  
  def total_funds(params={})
    MaintenanceFund.count :conditions => conditions 
  end
  
  def datatable_columns(column_id)
    case column_id.to_i
    when 0
      return "maintenance_funds.name"
    when 1
      return "maintenance_funds.collector"
    when 2
      return "maintenance_funds.street"
    when 3
      return "maintenance_funds.city"
    when 4
      return "maintenance_funds.state"
    when 5
      return "maintenance_funds.zip"
    end
  end
  
  def conditions
    conditions = []
    match_string = ActiveRecord::Base.connection.quote("%#{params[:sSearch]}%")
    conditions << "(maintenance_funds.name ILIKE #{match_string} OR " +
                  "maintenance_funds.collector ILIKE #{match_string} OR " +
                  "maintenance_funds.street ILIKE #{match_string} OR " +
                  "maintenance_funds.zip ILIKE #{match_string} OR " +
                  "maintenance_funds.street ILIKE #{match_string})" if (params[:sSearch])
    return conditions.join(" AND ")
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
  end
end