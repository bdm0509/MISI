namespace :import do
  require 'csv'
  
  desc "Clear everything that is imported out"
  task :clear_all => :environment do
    MaintenanceFundFee.delete_all
    MaintenanceOrder.delete_all
    MaintenanceFund.delete_all
    Assured.delete_all
    FeeCollectionType.delete_all
  end
  
  desc "Import all database files from dumps"
  task :all => [:clear_all, :environment] do    
    # Start importing
    Rake::Task["import:fee_collection_types"].invoke
    Rake::Task["import:assureds"].invoke
    Rake::Task["import:maintenance_funds"].invoke
    Rake::Task["import:maintenance_orders"].invoke
    Rake::Task["import:maintenance_fund_fees"].invoke
  end
  
  desc "Import Assureds from a CSV file"
  task :assureds => :environment do
    
    filename = File.join Rails.root, "utils/assureds_export.csv"
    puts "Importing Assureds from #{filename}"
    csv_text = File.read(filename)
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      data = row.to_hash
      assured = Assured.new(
                      id:      data["id"].to_i,
                      title:   data["title"],
                      street:  data["street"],
                      city:    data["city"],
                      state:   data["state"],
                      zip:     data["zip"],
                      fee:     data["fee"].to_f,
                      phone:   data["phone"],
                      contact: data["contact"])
                      
      assured.save(validate: false)
    end
  end
  
  desc "Import Maintenance Funds from a CSV file"
  task :maintenance_funds => :environment do
    
    filename = File.join Rails.root, "utils/maintenance_funds_export.csv"
    puts "Importing Maintenance Funds from #{filename}"
    csv_text = File.read(filename)
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      data = row.to_hash
      fund = MaintenanceFund.new(
                      id:             data["id"].to_i, 
                      name:           data["name"],
                      collector:      data["collector"], 
                      street:         data["street"],
                      city:           data["city"],
                      state:          data["state"],
                      zip:            data["zip"],
                      phone:          data["phone"],
                      contact:        data["contact"],
                      instructions:   data["instructions"],
                      amenities:      data["amenities"],
                      email:          data["email"],
                      fax:            data["fax"])
                      
      fund.save(validate: false)
    end
  end
  
  desc "Import Maintenance Orders from a CSV file and link"
  task :maintenance_orders => :environment do
    
    filename = File.join Rails.root, "utils/maintenance_orders_export.csv"
    puts "Importing Maintenance Orders from #{filename}"
    csv_text = File.read(filename)
    csv = CSV.parse(csv_text, :headers => true)
    
    csv.each do |row|
      data = row.to_hash
      
      foo = data["archived"].downcase
      puts ("archived: '#{foo}'") unless ["t", "f"].include? foo
      
      archived = data["archived"].downcase == 't' ? true : false
      order = MaintenanceOrder.new(
                      order_date:           data["order_date"],
                      report_date:          data["report_date"],
                      legal_description:    data["legal_description"],
                      buyer:                data["buyer"],
                      seller:               data["seller"],
                      property_address:     data["property_address"], 
                      date_checked:         data["date_checked"], 
                      special_instructions: data["special_instructions"],
                      amenities:            data["amenities"],
                      delinquent:           data["delinquent"],
                      gf:                   data["gf"],
                      hoa_fee:              data["hoa_fee"],
                      hoa_fee_year:         data["hoa_fee_year"],
                      hoa_collector:        data["hoa_collector"],
                      hoa_street:           data["hoa_street"],
                      hoa_city:             data["hoa_city"],
                      hoa_state:            data["hoa_state"],
                      hoa_zip:              data["hoa_zip"],
                      hoa_phone:            data["hoa_phone"],
                      hoa_fax:              data["hoa_fax"],
                      hoa_email:            data["hoa_email"],
                      order_status:         data["order_status"],
                      archived:             archived)
                      
      assured_id = data['assured_id'].to_i
      if assured_id > 0
        order.assured = Assured.find(assured_id)
      end
      
      maintenance_fund_id = data['maintenance_fund_id'].to_i
      if maintenance_fund_id > 0
        order.maintenance_fund = MaintenanceFund.find(maintenance_fund_id)
      end
                            
      order.save(validate: false)
    end
  end
  
  desc "Import Maintenance Fund Fees from a CSV file and link"
  task :maintenance_fund_fees => :environment do
    
    filename = File.join Rails.root, "utils/maintenance_fund_fees_export.csv"
    puts "Importing Maintenance Fund Fees from #{filename}"
    csv_text = File.read(filename)
    csv = CSV.parse(csv_text, :headers => true)
    
    csv.each do |row|
      data = row.to_hash
      
      fee = MaintenanceFundFee.new(
                      year:           data["year"],
                      amount:         data["amount"] ||= 0, 
                      how_collected:  data["how_collected"],
                      other_fee_type: data["other_fee_type"]) 
                      
      maintenance_fund_id = data['maintenance_fund_id'].to_i
      if maintenance_fund_id > 0
        fee.maintenance_fund = MaintenanceFund.find(maintenance_fund_id)
      end

      fee_collection_type_id = data['fee_collection_type_id'].to_i
      if fee_collection_type_id > 0
        fee.fee_collection_type = FeeCollectionType.find(fee_collection_type_id)
      end
                            
      fee.save(validate: false)
    end
  end
  
  desc "Import Fee Collection Types from a CSV file"
  task :fee_collection_types => :environment do
    
    filename = File.join Rails.root, "utils/fee_collection_types_export.csv"
    puts "Importing Fee Collection Types from #{filename}"
    csv_text = File.read(filename)
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      data = row.to_hash
      fee_type = FeeCollectionType.new(
                      id:             data["id"],
                      type_string:    data["type_string"], 
                      description:    data["description"])
                      
      fee_type.save
    end
  end

end
