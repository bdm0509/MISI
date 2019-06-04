class DelinquentTaxEntry < ApplicationRecord
  validates :account_number, :year_due, :amount, :presence => true
  
  belongs_to :collection_district
  
  belongs_to :tax_certificate
end
