class MaintenanceFundFee < ApplicationRecord
  validates :year, :amount, :presence => true
  # Moved year field to allow for dashes
  # validates :year, :numericality => { :only_integer => true, :greater_than => 0 }
  belongs_to :maintenance_fund
  belongs_to :fee_collection_type
end
