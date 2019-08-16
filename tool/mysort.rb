#!/usr/local/bin/ruby -Ku
# encoding: utf-8

#$:.unshift File.join(File.dirname(__FILE__),"tool")
$:.unshift File.expand_path("tool", ENV['E_KEISAN'])
require 'index_number'

#NUM=3
NUM=1

args = CatArguments.new(ARGV)

#p args[:index_number]
unless args[:index_number].nil?
	index_n=args[:index_number].to_i
else
	index_n=NUM
end

#p index_n 
#p ARGV


data = []
ARGF.each do |line|
  data << line.chop.split(',')
end
data.sort{ |a, b| a[index_n] <=> b[index_n]}.each do |l|
	puts l.join(",")
end

