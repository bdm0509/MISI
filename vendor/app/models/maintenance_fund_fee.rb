class MaintenanceFundFee < ActiveRecord::Base
  validates :year, :amount, :presence => true
  validates :year,   :numericality => { :only_integer => true, :greater_than => 0 }

  belongs_to :maintenance_fund
  belongs_to :fee_collection_type
end
