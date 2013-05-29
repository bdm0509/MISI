#!/usr/bin/env ruby
#
# Import Assureds to MISI
#
require 'optparse'
require 'rubygems'
require 'active_record'

# This hash will hold all of the options parsed
# from the command-line by OptionsParser
options = {}

optparse = OptionParser.new do |opts|
  # Banner
  opts.banner = "Usage: massage_maint [options] filename ..."

  # Define options
  
  # Option: -o, --out FILE
  options[:outputfile] = false
  opts.on('-o', '--out FILE', 'Output massaged data to FILE') do |file|
    options[:outputfile] = file
  end

  # Option: -v, --verbose
  options[:verbose] = false
  opts.on('-v', '--verbose', 'Output more information') do
    options[:verbose] = true
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

unless options[:outputfile]
  abort "You must specify an output file!"
end

puts "Outputting massaged maintainance funds to #{options[:outputfile]}"
puts "Importing verbose" if options[:verbose]
puts "Logging to file #{options[:logfile]}" if options[:logfile]

begin
  File.open("#{options[:outputfile]}", 'w') do |output|
    
    ARGV.each do |file|
      puts "Importing data from #{file}..."
      File.new("#{file}", "r").each { |line|
        line = line.gsub(/^ASSOCIATION:/, "*** *** ***\nASSOCIATION:") \
                   .gsub(/UPDATED ON:/, "\nUPDATED ON:") \
                   .gsub(/YEAR:/, "\nYEAR:") \
                   .gsub(/AMOUNT:/, "\nAMOUNT:") \
                   .gsub(/PHONE/, "\nPHONE:") \
                   .gsub(/ADDRESS/, "\nADDRESS") \
                   .gsub(/COLLECTOR/, "\nCOLLECTOR") \
                   .gsub(/HOW COLLECTED:/, "\nHOW COLLECTED:")
        if line.match(/^ADDRESS/)
          line = line.gsub(/TX/, "\nSTATE: TX\nZIP:").gsub(/Tx/, "\nSTATE: TX\nZIP:").gsub(/   [A-Z]/) { "\nCITY: #{$&.strip}" }
        end
        
        # Special case: weed out comma-ended lines with Houston in them
        if line.match(/^CITY/)
          line = line.gsub(/Houston,/, "Houston")
        end
        
        # Split phone and any extra contact information
        contact_part = ""
        
        unless line.match(/^PHONE:  NA/)
          if line.match(/^PHONE: /)
            phone_line = /^PHONE.+$/.match(line)
            if phone_line[0].strip.length > 0
              contact_part = phone_line[0].gsub(/^(\D*\d){10}/, '')
              if contact_part.length > 0
                line = line.gsub(contact_part, "")
                contact_part = contact_part.strip \
                                           .gsub(/^- /, "") \
                                           .gsub(/^\//, "") \
                                           .gsub(/^or /, "") \
                                           .gsub(/, /, "") \
                                           .gsub(/^\(/, "") \
                                           .gsub(/\)$/, "")
                if contact_part.strip.length > 0   
                  contact_part = "CONTACT: #{contact_part}" unless contact_part.match(/PHONE: /)
                end
              end
            end
          end
        end
        
        output.puts "#{line.strip}" unless line.strip.length == 0
        output.puts "#{contact_part}" unless contact_part.strip.length == 0
      }
    end
  end 
end