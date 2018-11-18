class MaintenanceFund < ActiveRecord::Base
  validates :name, :presence => true
  
  has_many :maintenance_orders, :dependent => :destroy
  has_many :maintenance_fund_fees, :dependent => :destroy
end
