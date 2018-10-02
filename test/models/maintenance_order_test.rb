require 'test_helper'

class MaintenanceOrderTest < ActiveSupport::TestCase
  def setup
    @maintenance_fund = maintenance_funds(:main_fund)
    @assured = assureds(:assured_one)
    
    @maintenance_order = MaintenanceOrder.new(order_date: Date.today, report_date: Date.tomorrow)
    @maintenance_order.maintenance_fund = @maintenance_fund
    @maintenance_order.assured = @assured
    
    @other_maintenance_order = MaintenanceOrder.new(order_date: Date.today, report_date: Date.tomorrow)
    @other_maintenance_order.maintenance_fund = @maintenance_fund
    @other_maintenance_order.assured = @assured
  end
  
  test "both maintenance orders should be valid" do
    assert @maintenance_order.valid?
    assert @other_maintenance_order.valid?
  end
  
  test "order_date should be present" do
    @maintenance_order.order_date = nil
    assert_not @maintenance_order.valid?
  end
  
  test "report_date should be present" do
    @maintenance_order.report_date = nil
    assert_not @maintenance_order.valid?
  end
  
  test "Maintenance Orders must have a maintenance fund" do
    @maintenance_order.maintenance_fund = nil
    assert_not @maintenance_order.valid?
  end
  
  test "Maintenance Orders must have an assured" do
    @maintenance_order.assured = nil
    assert_not @maintenance_order.valid?
  end
end
