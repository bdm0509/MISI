desc "Archive maintenance orders every night"
task :archive_maintenance_orders => :environment do
  puts "Archiving all old maintenance orders..."
  MaintenanceOrder.archive
  puts "Archiving complete"
end