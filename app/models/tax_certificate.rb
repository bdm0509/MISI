class TaxCertificate < ApplicationRecord
  validates :gf, :buyer, :certificate, :property_address, :presence => true
end
