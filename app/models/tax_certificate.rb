class TaxCertificate < ApplicationRecord
  belongs_to :assured
  has_many :tax_entries
  has_many :delinquent_tax_entries
  
  validates :gf, :buyer, :certificate, :property_address, :presence => true
end
