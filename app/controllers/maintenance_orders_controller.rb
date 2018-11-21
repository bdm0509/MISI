class MaintenanceOrdersController < ApplicationController
  require 'pdfcrowd'

  def new
    @title = "Create New Maintenance Order"
    @maintenance_order = MaintenanceOrder.new
  end
  
  def index
    @title = "Maintenance Order Listings"
    @new_maintenance_order_id = params[:id]
    
    # Convert string flag to a boolean
    show_archived = params[:show_archived]
    archive_flag = show_archived == 'true' || false
    @showing_archived = false
    @showing_archived = true if archive_flag == true || archive_flag =~ (/(true|t|yes|y|1)$/i)
    
    if @showing_archived
      #@maintenance_orders = MaintenanceOrder.all
      @maintenance_orders = MaintenanceOrder.limit(100)
    else
      @maintenance_orders = MaintenanceOrder.where(archived: @showing_archived).limit(100)
    end
    @new_maintenance_order_id = params[:id]
    
    respond_to do |format|
      format.html
      format.json { render json: MaintenanceOrdersDatatable.new(view_context, @showing_archived) }
    end
  end
  
  def create
    @maintenance_order = MaintenanceOrder.new(maintenance_order_params)
    if @maintenance_order.save
      flash[:success] = "The maintenance order #{@maintenance_order.order_date} has been created."
      redirect_to :controller => 'maintenance_orders', :action => 'index', :id => @maintenance_order.id
    else
      @title = "Create New Maintenance Order"
      render 'new'
    end
  end
  
  def show
    @maintenance_order = MaintenanceOrder.find(params[:id])
    @title = "Maintenance Order (#{@maintenance_order.order_date})"
  end
  
  def update
    @maintenance_order = MaintenanceOrder.find(params[:id])
    if @maintenance_order.update_attributes(maintenance_order_params)
      flash[:success] = "The maintenance order #{@maintenance_order.order_date} has been updated."
      redirect_to @maintenance_order
    else
      @title = "Maintenance Order (#{@maintenance_order.order_date})"
      render 'show'
    end
  end
  
  def destroy
    @maintenance_order = MaintenanceOrder.find(params[:id])
    if @maintenance_order.destroy
      flash[:success] = "The maintenance order #{@maintenance_order.order_date} has been deleted."
    else
      flash[:error] = "Error deleting maintenance order: #{@maintenance_order.order_date}"
    end
    
    redirect_to :controller => 'maintenance_orders', :action => 'index'
  end
  
  def print
    puts "PRINTING REQUESTED"
    
    begin
      # client = Pdfcrowd::Client.new("misi", "afec1b458239c068061334c4fe8f93a6")
      client = Pdfcrowd::HtmlToPdfClient.new("misi", "afec1b458239c068061334c4fe8f93a6")
#      client.setHorizontalMargin("0.25in")
#      client.setVerticalMargin("0.5in")
#    client.setHeaderHtml("<div id='print_header' style='text-align: right'><p>#{Time.now.strftime("%m/%d/%Y")}</p></div>")
#      client.setFooterHtml("<div id='print_footer' style='text-align: right'><p>Page %p of %n</p></div>")
      
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
      
      output_file = open("tmp/misi_maint_order-#{@maintenance_order.id}.pdf", "wb") 
      pdf = client.convertString(order_listing)
      output_file.write(pdf)
      output_file.close()

      # send the generated PDF
      puts "IN FORMAT"
          
      send_data pdf, filename: "misi_maint_order-#{@maintenance_order.id}.pdf", type: :pdf, :disposition => "attachment"
    rescue Pdfcrowd::Error => why
      puts why
      puts "Got here"
      render :text => why
    end
  end
  
private
  def maintenance_order_params
    params.require(:maintenance_order).permit(:report_date, :order_date, :gf,
                                              :assured_id, 
                                              :legal_description, :buyer, :seller,
                                              :property_address, 
                                              :maintenance_fund_id,
                                              :order_status, :delinquent,
                                              :hoa_fee, :hoa_fee_year, :hoa_collector,
                                              :hoa_street, :hoa_state, :hoa_zip,
                                              :hoa_phone, :hoa_fax, :hoa_email,
                                              :special_instructions, :amenities)
  end
end
