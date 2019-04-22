class TaxCertificatesDatatable
  include ERB::Util
  delegate :params, :h, :link_to, :number_to_currency, to: :@view
  
  def initialize(view, showing_archived)
    @view = view
    @showing_archived = showing_archived
  end
  
  def as_json(options = {}) 
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: TaxCertificate.count,
      iTotalDisplayRecords: tax_certificates.total_entries,
      aaData: data
    }
  end
  
private

  def data
    tax_certificates.map do |tax_certificate|
      [
        link_to(tax_certificate.gf, tax_certificate, class: "underline"),
        html_escape(tax_certificate.assured.title),
        html_escape(tax_certificate.order),
        html_escape(tax_certificate.property_address),
        link_to("Delete", tax_certificate, 
                method: :delete, 
                data: { confirm: "Are you sure you want to delete this tax certificate?" }, 
                class: "button delete"
        )
      ]
    end
  end

  def tax_certificates
    @tax_certificates ||= fetch_tax_certificates
  end

  def fetch_tax_certificates    
    if @showing_archived
      tax_certificates = TaxCertificate.order("#{sort_column} #{sort_direction}")
    else
      tax_certificates = TaxCertificate.where(archived: @showing_archived).order("#{sort_column} #{sort_direction}")
    end
    tax_certificates = 
      tax_certificates.paginate(:page => page,
                                  :per_page => per_page)
    if params[:sSearch].present?
      tax_certificates = 
        tax_certificates.where("lower(gf) like :search or lower(title_company) like :search or lower(property_address) like :search", 
          search: "%#{params[:sSearch].gsub('/', '-')}%".downcase)
    end
    tax_certificates
  end
  
  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 25
  end
  
  def sort_column
    columns = %w[gf title_company order property_address]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end