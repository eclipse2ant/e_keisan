#!/usr/local/bin/ruby -Ku
# encoding: utf-8

#$:.unshift File.join(File.dirname(__FILE__),"tool")
$:.unshift File.expand_path("tool", ENV['E_KEISAN'])
require 'addlist'

m=1
d=[]
ARGV.each do |f|
	data = read_file(f)
	d<< data
end

add_list(d,m)


