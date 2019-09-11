#!/usr/local/jruby/bin/jruby  
#encoding: utf-8

#p __FILE__
#$:.unshift File.join(File.dirname(__FILE__))
$:.unshift File.expand_path("lib", ENV['E_KEISAN'])

#require 'excel'
require 'jrev_util'


include RevUtil

#p ARGV[1]





list=[]
begin
  ifile = get_filename(ARGV[0])
  wb=get_workbook(ifile)
  sh=get_sheet(wb)
  SheetHolder.instance.sheet=sh
  i=0
  for i in 6..58 do
    list<< [sh[i,1],sh[i,5]]
  end
  for i in 67..2240 do
    list<< [sh[i,1],sh[i,5]]
  end
  p list[0][1]
ensure
  ifile.close
#  ofile.close
end
