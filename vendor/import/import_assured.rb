#!/usr/bin/env ruby
#
# Import Assureds to MISI
#
require 'optparse'
require 'assured_parser.rb'
require rubygems'
require 'active_record'

# This hash will hold all of the options parsed
# from the command-line by OptionsParser
options = {}

optparse = OptionParser.new do |opts|
  # Banner
  opts.banner = "Usage: import_assureds [options] filename ..."

  # Define options

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

puts "Importing verbose" if options[:verbose]
puts "Logging to file #{options[:logfile]}" if options[:logfile]

ARGV.each do |file|
  puts "Importing data from #{file}..."
  File.new("#{file}", "r").each { |line|
    AssuredParser.parse(line)
  }
end
