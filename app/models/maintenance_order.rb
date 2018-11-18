<<<<<<< HEAD
class MaintenanceOrder < ApplicationRecord
=======
class MaintenanceOrder < ActiveRecord::Base
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
  belongs_to :assured
  belongs_to :maintenance_fund
  
  validates :order_date, :report_date,
            :presence => true
  validates :assured, :maintenance_fund, :presence => true
<<<<<<< HEAD
=======
  
  def self.archive
    self.select { |o|
      !o.archived && (o.report_date < Date.today - 6.months)
    }.each { |r|
      r.archived = true
      r.save
      puts "Archiving maintenance order #{r.id} with report date #{r.report_date} (Property address #{r.property_address} " +
           "for assured #{r.assured.title} and seller #{r.seller})"
    }
  end
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
end
