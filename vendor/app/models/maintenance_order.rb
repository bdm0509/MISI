class MaintenanceOrder < ActiveRecord::Base
  belongs_to :assured
  belongs_to :maintenance_fund
  
  validates :order_date, :report_date,
            :presence => true
  validates :assured, :maintenance_fund, :presence => true
end
