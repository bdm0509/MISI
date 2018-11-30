class MaintenanceOrder < ApplicationRecord
  belongs_to :assured
  belongs_to :maintenance_fund
  
  validates :order_date, :report_date,
            :presence => true
  validates :assured, :maintenance_fund, :presence => true
  
  def report_date= stringDate
    write_attribute :report_date, Date.strptime(stringDate, "%m/%d/%Y")
  end
  
  def order_date= stringDate
    write_attribute :order_date, Date.strptime(stringDate, "%m/%d/%Y")
  end
end
