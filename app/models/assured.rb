class Assured < ApplicationRecord
  validates :title, :street, :city, :state, :zip, :phone, :contact, :fee, :presence => true
  validates :fee, :numericality => { :greater_than_or_equal_to => 0 }
  
  has_many :maintenance_orders, :dependent => :destroy
  
  DEFAULT_FEE = 67.12
end
