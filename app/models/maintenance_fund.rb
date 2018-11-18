<<<<<<< HEAD
class MaintenanceFund < ApplicationRecord
=======
class MaintenanceFund < ActiveRecord::Base
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
  validates :name, :presence => true
  
  has_many :maintenance_orders, :dependent => :destroy
  has_many :maintenance_fund_fees, :dependent => :destroy
end
