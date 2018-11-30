class MaintenanceOrder < ApplicationRecord
  belongs_to :assured
  belongs_to :maintenance_fund
  
  validates :order_date, :report_date,
            :presence => true
  validates :assured, :maintenance_fund, :presence => true
  
  before_validation :format_dates
  
  def format_dates
    puts "Formatting dates for validation"
    self.report_date = Date.strptime(report_date, "%m/%d/%Y")
    self.order_date = Date.strptime(order_date, "%m/%d/%Y")
  end
end
