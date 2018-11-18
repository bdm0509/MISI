<<<<<<< HEAD
class Assured < ApplicationRecord
=======
class Assured < ActiveRecord::Base
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
  validates :title, :street, :city, :state, :zip, :phone, :contact, :fee, :presence => true
  validates :fee, :numericality => { :greater_than_or_equal_to => 0 }
  
  has_many :maintenance_orders, :dependent => :destroy
  
  DEFAULT_FEE = 67.12
end
