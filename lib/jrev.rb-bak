#!/usr/local/jruby/bin/jruby  
#encoding: utf-8

#p __FILE__
#$:.unshift File.join(File.dirname(__FILE__))
$:.unshift File.expand_path("lib", ENV['E_KEISAN'])

#require 'excel'
require 'jrev_util'


include RevUtil

p ARGV[0]

begin
  ifile = get_filename(ARGV[0])
  wb=get_workbook(ifile)
  sh=SheetHolder.instance.sheet
  sh=get_sheet(wb)
  sh[2,6]="501"
  p sh[2,6]
  ofile=put_filename(ARGV[0])
  wb.write(ofile)
ensure
  ifile.close
  ofile.close
end
