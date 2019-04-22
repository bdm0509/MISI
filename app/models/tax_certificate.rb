class TaxCertificate < ApplicationRecord
  belongs_to :assured
  
  validates :gf, :buyer, :certificate, :property_address, :presence => true
end
