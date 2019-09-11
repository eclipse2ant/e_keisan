#!/usr/local/jruby/bin/jruby  
#encoding: utf-8

#p __FILE__
#$:.unshift File.join(File.dirname(__FILE__))
$:.unshift File.expand_path("lib", ENV['E_KEISAN'])

#require 'excel'
require 'jrev_util'


include RevUtil

p ARGV[1]





list=[]
begin
  ifile = get_filename(ARGV[0])
  wb=get_workbook(ifile)
#  sh=SheetHolder.instance.sheet
  sh=get_sheet(wb)
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

begin
  ifile = get_filename(ARGV[1])
  wb=get_workbook(ifile)
#  sh=SheetHolder.instance.sheet
  sh=get_sheet(wb)
#  p sh[7,50]
#  sh[9,51]=list[0][1]
#  p sh[9,51]
  list.each do |d|
    j=0
    for j in 9..2199 do
      if sh[j,2]==d[0]
        sh[j,51]=d[1]
        break
      end
    end
  end
  ofile=put_filename(ARGV[1])
  wb.write(ofile)
ensure
  ifile.close
  ofile.close
end
