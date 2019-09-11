#!/usr/local/jruby/bin/jruby  
#encoding: utf-8

#p __FILE__
#$:.unshift File.join(File.dirname(__FILE__))
$:.unshift File.expand_path("lib", ENV['E_KEISAN'])

#require 'excel'
require 'jrev_util'


include RevUtil

p ARGV[0]
filename = get_filename(ARGV[0])
sheet=SheetHolder.instance.sheet
sheet=get_sheet(filename)
sheet[2,6]="501"
p sheet[2,6]
