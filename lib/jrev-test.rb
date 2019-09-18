#!/usr/local/jruby/bin/jruby  
#encoding: utf-8

#p __FILE__
#$:.unshift File.join(File.dirname(__FILE__))
$:.unshift File.expand_path("lib", ENV['E_KEISAN'])

#require 'excel'
require 'jrev_util'


include RevUtil

p ARGV[0]





list=[]
begin
  ifile = get_filename(ARGV[0])
  wb=get_workbook(ifile)
  sh=get_sheet(wb)
#  SheetHolder.instance.sheet=sh
    p sh[1,5]
    p sh[2,5]
ensure
  ifile.close
#  ofile.close
end

