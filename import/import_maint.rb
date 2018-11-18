#!/usr/bin/env ruby
#
# Import HOAs to MISI
#
require 'optparse'
require 'rubygems'
require 'active_record'

# This hash will hold all of the options parsed
# from the command-line by OptionsParser
options = {}

optparse = OptionParser.new do |opts|
  # Banner
  opts.banner = "Usage: import_maint [options] filename ..."

  # Define options

  # Option: -v, --verbose
  options[:verbose] = false
  opts.on('-v', '--verbose', 'Output more information') do
    options[:verbose] = true
  end
  
  # Option: -n --nuke
  options[:nuke] = false
  opts.on('-n', '--nuke', 'Blow away all existing maintenance orders first') do
    options[:nuke] = true
  end

  # Option: -l, --logfile FILE
  options[:logfile] = nil
  opts.on('-l', '--logfile FILE', 'Write log to FILE') do |file|
    options[:logfile] = file
  end

  # Option: -g, --help
  opts.on('-h', '--help', 'Display this screen') do
    puts opts
    exit
  end
end

optparse.parse!

puts "Importing verbose" if options[:verbose]
puts "Logging to file #{options[:logfile]}" if options[:logfile]

# Connect to database
ActiveRecord::Base.establish_connection({
## Local settings
#  :adapter => "jdbcmysql",
#  :host => "localhost",
#  :port => 8889,
#  :username => "root",
#  :password => "root",
#  :database => "misi_development"

## EngineYard settings
  :adapter  =>  'mysql2',
  :database =>  "misi",
  :username =>  "deploy",
  :password =>  "AKfV1rPOYb",
  :host =>      "127.0.0.1",
  :port =>      3307
})
  
# Define funds/HOAs
class MaintenanceFund < ActiveRecord::Base
  validates :name, :presence => true
  #validates :name, :collector, :street, :city, :state, :zip, :phone, :contact, :instructions, :amenities, :presence => true
  
  #has_many :maintenance_orders, :dependent => :destroy
  has_many :maintenance_fund_fees, :dependent => :destroy
end

class MaintenanceFundFee < ActiveRecord::Base
  validates :year, :presence => true
  validates :year, :numericality => { :only_integer => true, :greater_than => 0 }
  
  belongs_to :maintenance_fund
  belongs_to :fee_collection_type
end

class FeeCollectionType < ActiveRecord::Base
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
      write_attribute(:type_string, description.gsub(/\s+/, "").upcase)
    end
  end
end

MaintenanceFund.destroy_all if options[:nuke]

ARGV.each do |file|
  puts "Importing data from #{file}..."
  
  inHOA = false
  currentHOA = nil
  hoaCount = 0;
  
  fee_year = nil
  fee_amount = nil
  fee_how_collected = nil
  
  File.new("#{file}", "r").each { |line|
    
    # Every time we hit *** *** ***, it's a new HOA
    if line.match(/\*\*\* \*\*\* \*\*\*/)
      if inHOA
        # Figure out the fee type
        unless fee_how_collected.nil?
          fee_collection_type = 
            FeeCollectionType.find_by_type_string(fee_how_collected).nil? ? FeeCollectionType.find_by_type_string("Other") : 
                                                                            FeeCollectionType.find_by_type_string(fee_how_collected)
          
          maintenance_fund_fee = MaintenanceFundFee.new(
            :amount              => fee_amount,
            :year                => fee_year,
            :fee_collection_type => fee_collection_type
          )
          currentHOA.maintenance_fund_fees << maintenance_fund_fee
        end
        
        # Save current HOA
        if currentHOA.valid?
          puts "\t\tSaving HOA: #{currentHOA.name}\n"
          currentHOA.save!
        else
          message = "The current HOA, " + currentHOA.name + ", is invalid: " + currentHOA.errors.inspect
          if currentHOA.maintenance_fund_fees.first.invalid?
            message = message + "\n" + currentHOA.maintenance_fund_fees.first.errors.inspect
          end
          abort message
        end
      end
      
      # Start a new fund/HOA
      currentHOA = MaintenanceFund.new
      fee_year = nil
      fee_amount = nil
      fee_how_collected = nil
      inHOA = true
      
      hoaCount = hoaCount + 1;
    else
      begin
        if line.match(/^ASSOCIATION:/)
          # name is required, so no error-handling here
          currentHOA.name = line.match(/ASSOCIATION:(.+)$/)[1].strip
          puts "Creating new HOA: #{currentHOA.name}..."
        elsif line.match(/^COLLECTOR:/)
          collector = line.match(/COLLECTOR:(.+)$/)
          currentHOA.collector = collector[1].strip unless collector.nil?
        elsif line.match(/^UPDATED ON:/)
          # Anything here?
        elsif line.match(/^ADDRESS:/)
          street = line.match(/ADDRESS:(.+)$/)
          unless street.nil? or street[1].gsub(/ /,'').length == 0
            currentHOA.street = street[1].strip unless street.nil?
          end
        elsif line.match(/^CITY:/)
          city = line.match(/CITY:(.+)$/)
          currentHOA.city = city[1].strip unless city.nil?
        elsif line.match(/^STATE:/)
          state = line.match(/STATE:(.+)$/)
          currentHOA.state = state[1].strip unless state.nil?
        elsif line.match(/^ZIP:/)
          zip = line.match(/ZIP:(.+)$/)
          unless zip.nil? or zip[1].gsub(/ /,'').length == 0
            currentHOA.zip = zip[1].strip
          end
        elsif line.match(/^PHONE:/)
          phone = line.match(/PHONE:(.+)$/)
          currentHOA.phone = phone[1].strip unless phone.nil?
        elsif line.match(/^CONTACT:/)
          contact = line.match(/CONTACT:(.+)$/)
          currentHOA.contact = contact[1].strip unless contact.nil?
        elsif line.match(/^SPECIAL INSTRUCTIONS/)
          instructions = line.match(/SPECIAL INSTRUCTIONS:(.+)$/)
          currentHOA.instructions = instructions[1].strip unless instructions.nil?
        elsif line.match(/^YEAR/)          
          fee_year = line.match(/YEAR:(.+)$/)[1].strip
        elsif line.match(/^AMOUNT/)
          amount = line.match(/AMOUNT:(.+)$/)
          unless amount.nil? or amount[1].gsub(/ /,'').length == 0
            fee_amount = amount[1].strip
          end
        elsif line.match(/^HOW COLLECTED/)
          if line.match(/HOW COLLECTED:(.+)$/)
            fee_how_collected = line.match(/HOW COLLECTED:(.+)$/)[1].strip unless line.match(/HOW COLLECTED:(.+)$/)[1].nil?
          end
        end
      rescue Exception => exc
        abort "Error: #{exc.message} for '#{line}'"
      end
    end
  }
  
  # Save the (last) current HOA
  if inHOA
    currentHOA.save!
  end
  
  puts "Found #{hoaCount} HOAs"
end
