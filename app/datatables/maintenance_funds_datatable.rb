class MaintenanceFundsDatatable
  include ERB::Util
  delegate :params, :h, :link_to, :number_to_currency, to: :@view
  
  def initialize(view)
    @view = view
  end
  
  def as_json(options = {}) 
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: MaintenanceFund.count,
      iTotalDisplayRecords: maintenance_funds.total_entries,
      aaData: data
    }
  end
  
private

  def data
    maintenance_funds.map do |maintenance_fund|
      [
        link_to(maintenance_fund.name, maintenance_fund, class: "underline"),
        html_escape(maintenance_fund.collector),
        html_escape(maintenance_fund.street),
        html_escape(maintenance_fund.city),
        html_escape(maintenance_fund.state),
        html_escape(maintenance_fund.zip),
        "<a href='javascript:maintenance_fund_contact_info(" +
          "\"" + maintenance_fund.name + "\", " +
          "\"" + (maintenance_fund.contact && maintenance_fund.contact.size > 0  ? maintenance_fund.contact : "") + "\", " +
          "\"" + (maintenance_fund.phone && maintenance_fund.phone.size > 0  ? maintenance_fund.phone : "") + "\");' class='underline'>Contact Information</a>" +
          "<input type=\"hidden\" class=\"maintenance_fund_contact_name\" " +
          "value=\"" + (maintenance_fund.contact && maintenance_fund.contact.size > 0  ? maintenance_fund.contact : "") + "\" />" +
          "<input type=\"hidden\" class=\"maintenance_fund_contact_phone\" " +
          "value=\"" + (maintenance_fund.phone && maintenance_fund.phone.size > 0  ? maintenance_fund.phone : "") + "\" />",
        link_to("Delete", maintenance_fund, 
                method: :delete, 
                data: { confirm: "Are you sure you want to delete this HOA?" }, 
                class: "button delete"
        )
      ]
    end
  end
  
  def maintenance_funds
    @maintenance_funds ||= fetch_maintenance_funds
  end

  def fetch_maintenance_funds
    maintenance_funds = MaintenanceFund.order("#{sort_column} #{sort_direction}")
    maintenance_funds = 
      maintenance_funds.paginate(:page => page,
                                 :per_page => per_page)
    if params[:sSearch].present?
      maintenance_funds = 
        maintenance_funds.where("name like :search or collector like :search or street like :search or city like :search or zip like :search", 
          search: "%#{params[:sSearch]}%")
    end
    maintenance_funds
  end
  
  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 25
  end
  
  def sort_column
    columns = %w[name collector street city state zip]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end