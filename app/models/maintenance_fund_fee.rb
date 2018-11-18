<<<<<<< HEAD
class MaintenanceFundFee < ApplicationRecord
  validates :year, :amount, :presence => true
  validates :year, :numericality => { :only_integer => true, :greater_than => 0 }
=======
class MaintenanceFundFee < ActiveRecord::Base
  validates :year, :amount, :presence => true
  validates :year,   :numericality => { :only_integer => true, :greater_than => 0 }
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827

  belongs_to :maintenance_fund
  belongs_to :fee_collection_type
end
