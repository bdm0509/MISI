class TaxEntry < ApplicationRecord
  validates :account_number, :year, :base_tax, :presence => true
  
  belongs_to :district_type
  belongs_to :collection_district
  belongs_to :tax_status
  
  belongs_to :tax_certificate
end
