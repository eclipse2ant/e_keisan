#!/usr/local/jruby/bin/jruby  
# encoding: utf-8

#require 'java'
#java_import 'java.io.FileInputStream'

require 'excel'
require 'jgotei_util'


class Gotei

  include GoteiUtil
  def initialize(name)
    set_record(name)
  end

  def set_record(name)
    File.open(apath("data/nanatei.list"),"r:utf-8").each do |s|
      seibun = s.chop.split(',')
      if name.strip == seibun[0]
	      @record = []
	      x = seibun[4].to_i + 8
        rev = seibun[3].to_i
        filename=get_filename(rev)
        sheet=get_sheet(filename)
#        p sheet;
#        puts seibun[0]
	      1.upto(67) do |y|
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
