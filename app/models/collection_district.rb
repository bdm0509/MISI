class CollectionDistrict < ApplicationRecord
  validates :name, :presence => true
  
  has_many :tax_entries, :dependent => :destroy
end
