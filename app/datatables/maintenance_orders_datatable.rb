class MaintenanceOrdersDatatable
  include ERB::Util
  delegate :params, :h, :link_to, :number_to_currency, to: :@view
  
  def initialize(view, showing_archived)
    @view = view
    @showing_archived = showing_archived
  end
  
  def as_json(options = {}) 
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: MaintenanceOrder.count,
      iTotalDisplayRecords: maintenance_orders.total_entries,
      aaData: data
    }
  end
  
private

  def data
    maintenance_orders.map do |maintenance_order|
      [
        link_to(maintenance_order.order_date.strftime("%m/%d/%Y"), 
                maintenance_order, class: "underline"),
        html_escape(maintenance_order.order_date.strftime("%m/%d/%Y")),
        html_escape(maintenance_order.gf),
        html_escape(maintenance_order.assured.title),
        html_escape(maintenance_order.seller),
        html_escape(maintenance_order.property_address),
        link_to("Delete", maintenance_order, 
                method: :delete, 
                data: { confirm: "Are you sure you want to delete this maintenance order?" }, 
                class: "button delete"
        )
      ]
    end
  end

  def maintenance_orders
    @maintenance_orders ||= fetch_maintenance_orders
  end

  def fetch_maintenance_orders    
    if @showing_archived
      maintenance_orders = MaintenanceOrder.order("#{sort_column} #{sort_direction}")
    else
      maintenance_orders = MaintenanceOrder.where(archived: @showing_archived).order("#{sort_column} #{sort_direction}")
    end
    maintenance_orders = 
      maintenance_orders.paginate(:page => page,
                                  :per_page => per_page)
    if params[:sSearch].present?
      maintenance_orders = 
      # FIX ME ADD ASSURED TITLE
        maintenance_orders.where("lower(gf) like :search or lower(seller) like :search or lower(property_address) like :search", 
          search: "%#{params[:sSearch].gsub!('/', '-')}%".downcase)
    end
    maintenance_orders
  end
  
  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 25
  end
  
  def sort_column
    columns = %w[report_date order_date gf seller assured.title property_address]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end