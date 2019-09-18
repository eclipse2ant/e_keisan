#!/usr/local/jruby/bin/jruby  
# encoding: utf-8

#require 'java'
#java_import 'java.io.FileInputStream'

require 'excel'
require 'jgotei_util'


class Gotei

  include GoteiUtil
  def initialize(name)
    filenames = get_filenames
    begin
      sheets=SheetHolders.instance.sheets
#      p sheets
      unless  sheets==nil        
        set_record(name,sheets)  
      else
        Excel.runDuring do |excel|
          sheets=get_sheets(excel,filenames)
#          p sheet;
          set_record(name,sheets)
        end
      end
    ensure
      filesclose(filenames)
    end
  end

  def set_record(name,sheets)
    hed=[8,9,8]
    File.open(apath("data/nanatei.list"),"r:utf-8").each do |s|
      seibun = s.chop.split(',')
      if name.strip == seibun[0]
	      @record = []
        rev = seibun[3].to_i
	      x = seibun[4].to_i + hed[rev-1]
        sheet=sheets[rev-1]
#        p sheet
#         puts seibun[0]
#	      1.upto(67) do |y|
	      1.upto(68) do |y|
#         p sheet[x,y]
	        @record << sheet[x,y]
	      end
        break
      end
    end
    if @record == nil
	    raise "#{name} が見つかりません\n" 
    end
  end
  
attr_reader :record
end
