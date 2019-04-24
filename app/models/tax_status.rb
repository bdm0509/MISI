class TaxStatus < ApplicationRecord
  validates :status, :description, :presence => true
  before_validation :set_status
  
  has_many :tax_entries, :dependent => :destroy
  
  def description=(description)
    unless description.nil?
      write_attribute(:description, description)
      set_status
    end
  end
  
  def self.get_description(status)
    TaxStatus.find_by_status(status).description
  end
  
  def self.get_status(description)
    TaxStatus.find_by_description(description).status
  end
  
private
  def set_status
    description = read_attribute(:description)
    unless description.nil?
      write_attribute(:status, description.gsub(/\s+/, "_").upcase)
    end
  end
end
