#!/usr/local/jruby/bin/jruby  
# encoding: utf-8

#require 'java'
#java_import 'java.io.FileInputStream'

require 'excel'
require 'jgotei_util'


class Gotei

	include GoteiUtil
	def initialize(name)
#    p name
    filename = get_filename
    begin
      sheet=SheetHolder.instance.sheet
#      p sheet
      unless  sheet==nil	
        set_record(name,sheet)  
      else
        Excel.runDuring do |excel|
          sheet=get_sheet(excel,filename)
          set_record(name,sheet)
        end
      end
    ensure
      filename.close
    end
  end

=begin
	def initialize(name)
#		p name    #テスト
		filename = get_filename
		sheet=SheetHolder.instance.sheet
#		p sheet
		unless  sheet==nil	
			set_record(name,sheet)  
		else
			Excel.runDuring do |excel|
				sheet=get_sheet(excel,filename)
				set_record(name,sheet)
			end
		end
	end
=end

	def set_record(name,sheet)
		File.open(apath("gotei.list"),"r:utf-8").each do |s|
			seibun = s.chop.split(',')
##			if /^#{name.strip}$/ =~ seibun[0]
			if name.strip == seibun[0]
				@record = []
##				x = seibun[3] + 2
				x = seibun[3].to_i + 2
#				puts seibun[0]
				1.upto(45) do |y|
#          p sheet[x,y]
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

