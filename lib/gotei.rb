#!ruby -Ks
# encoding: Windows-31J


require 'excel'
require 'gotei_util'


class Gotei
	include GoteiUtil
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

	def set_record(name,sheet)
		File.open("gotei.list","r:Windows-31J").each do |s|
			seibun = s.chop.split(',')
#			if /^#{name.strip}$/ =~ seibun[0]
			if name.strip == seibun[0]
				@record = []
#				x = seibun[3] + 2
				x = seibun[3].to_i + 2
#				puts seibun[0]
				1.upto(45) do |y|
					@record << sheet[x,y]
				end
				break
			end
		end
		if @record == nil
			raise "#{name} が見つかりません" 
		end
	end

attr_reader :record
end

