class MaintenanceOrdersController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @title = "Maintenance Order Listings"
    @maintenance_orders = MaintenanceOrder.all
    @new_maintenance_order_id = params[:id]
  end
  
  def show
    @maintenance_order = MaintenanceOrder.find(params[:id])
    @title = "Maintenance Order (#{@maintenance_order.order_date})"
  end
  
  def print
    begin
      # create an API client instance
      client = Pdfcrowd::Client.new("misi", "afec1b458239c068061334c4fe8f93a6")
      client.setHorizontalMargin("0.25in")
      client.setVerticalMargin("0.5in")
      client.setHeaderHtml("<div id='print_header' style='text-align: right'><p>#{Time.now.strftime("%m/%d/%Y")}</p></div>")
      client.setFooterHtml("<div id='print_footer' style='text-align: right'><p>Page %p of %n</p></div>")
      
      @maintenance_order = MaintenanceOrder.find(params[:id])
      @title = "Maintenance Order (#{@maintenance_order.order_date})"
      @printing = true
      @maintenance_fund_fee = @maintenance_order.maintenance_fund.maintenance_fund_fees.order('year DESC').first
      
      order_listing = render_to_string(
        :partial => "maintenance_orders/print",
        :locals => { 
          :maintenance_order => @maintenance_order,
          :title => @title
        }
      )

      # convert a web page and store the generated PDF to a variable
      pdf = client.convertHtml(order_listing)

      # send the generated PDF
      send_data(pdf, 
                :filename => "misi_maint_order-#{@maintenance_order.id}.pdf",
                :type => "application/pdf",
                :disposition => "attachment")
    rescue Pdfcrowd::Error => why
      render :text => why
    end
  end
  
  def new
    @title = "Create New Maintenance Order"
    @maintenance_order = MaintenanceOrder.new
  end
  
  def create
    @maintenance_order = MaintenanceOrder.new(params[:maintenance_order])
    @maintenance_order.report_date = Date.strptime(params[:maintenance_order][:report_date], "%m/%d/%Y") unless params[:maintenance_order][:report_date].empty?
    @maintenance_order.order_date = Date.strptime(params[:maintenance_order][:order_date], "%m/%d/%Y") unless params[:maintenance_order][:order_date].empty?
    
    if @maintenance_order.save
      redirect_to :controller => 'maintenance_orders', :action => 'show', :id => @maintenance_order.id
    else
      @title = "Create New Maintenance Order"
      render 'new'
    end
  end
  
  def destroy
    @maintenance_order = MaintenanceOrder.find(params[:id])
    if @maintenance_order.destroy
      flash[:success] = "Maintenance Order deleted."
    else
      flash[:error] = "Error deleting maintenance order: #{@maintenance_order.errors}"
    end
    
    redirect_to :controller => 'maintenance_orders', :action => 'index'
  end
  
  def update
    @maintenance_order = MaintenanceOrder.find(params[:id])
    
    @maintenance_order.update_attributes(params[:maintenance_order])    
    @maintenance_order.report_date = Date.strptime(params[:maintenance_order][:report_date], "%m/%d/%Y") unless params[:maintenance_order][:report_date].empty?
    @maintenance_order.order_date = Date.strptime(params[:maintenance_order][:order_date], "%m/%d/%Y") unless params[:maintenance_order][:order_date].empty?

    if @maintenance_order.save
      respond_to do |format|
        format.html {
          flash[:success] = "Maintenance Order updated."
          redirect_to @maintenance_order
        }
        format.js
      end
    else
      respond_to do |format|
        format.html {
          @title = "Maintenance Order #{ @maintenance_order.id }"
          render 'show'
        }
        format.js {
          @errors = @maintenance_order.errors
        }
      end
    end
  end
  
  def update_special_characters
    @msg = ""
    MaintenanceOrder.where('special_instructions ILIKE ?', '%&amp;%').each do |mo|
      @msg += "Replacing special character &amp; in special instructions for maintenance order '#{mo.order_date}'...\n"
      mo.special_instructions = mo.special_instructions.gsub(/\&amp;/, "&")
      mo.save!
    end
    MaintenanceOrder.where('amenities ILIKE ?', '%&amp;%').each do |mo|
      @msg += "Replacing special character &amp; in amenities for maintenance order '#{mo.order_date}'...\n"
      mo.amenities = mo.amenities.gsub(/\&amp;/, "&")
      mo.save!
    end
  end
end
