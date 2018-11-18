<<<<<<< HEAD
class FeeCollectionType < ApplicationRecord
=======
class FeeCollectionType < ActiveRecord::Base
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
  validates :type_string, :description, :presence => true
  before_validation :set_type_string
  has_many :maintenance_fund_fees
  
  def description=(description)
    unless description.nil?
      write_attribute(:description, description)
      set_type_string
    end
  end
  
  def self.get_description(type_string)
    FeeCollectionType.find_by_type_string(type_string).description
  end
  
  def self.get_type(description)
    FeeCollectionType.find_by_description(description).type_string
  end
  
private
  def set_type_string
    description = read_attribute(:description)
    unless description.nil?
<<<<<<< HEAD
      write_attribute(:type_string, description.gsub(/\s+/, "_").upcase)
=======
      write_attribute(:type_string, description.gsub(/\s+/, "").upcase)
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
    end
  end
end
