class DistrictType < ApplicationRecord
  validates :type_string, :description, :presence => true
  before_validation :set_type_string
  
  has_many :tax_entries
  
  def description=(description)
    unless description.nil?
      write_attribute(:description, description)
      set_type_string
    end
  end
  
  def self.get_description(type_string)
    DistrictType.find_by_type_string(type_string).description
  end
  
  def self.get_type(description)
    DistrictType.find_by_description(description).type_string
  end
  
private
  def set_type_string
    description = read_attribute(:description)
    unless description.nil?
      write_attribute(:type_string, description.gsub(/\s+/, "_").upcase)
    end
  end
end
