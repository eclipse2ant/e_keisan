#!/usr/local/jruby/bin/jruby  
# encoding: utf-8


require 'jgotei'
require 'matrix'

class Shokuhin

	def initialize(name)
			@name=name
		begin
			@record=Gotei.new(@name).record
		rescue
			raise
		end
	end


	def number
		@record[1].to_i
	end


	def exact_name
		@record[3].strip
	end
		
include Apath

	def dm
#		p number
		File.open(apath("dm.list"),"r:utf-8").each do |s|
			list = s.chop.split(',')
#			p list
			if number == list[0].to_i
				return list[3].to_i
			end
		end
		return nil
	end	

	def seibun
		@record[4,66].insert(0,dm)
	end

	def v_seibun
		x=seibun
		dm=x.shift
		x.shift
		y=nil_to_0(x)
		z=koukan(dm)
		return Vector.elements(y.concat(z))
	end

attr_reader :name


	private 

	def trans(x)
		x=0 if x.nil?
		return x
	end

	def nil_to_0(array)
		l=array.collect do |x|
			trans(x)
		end
		return l  
	end


	def koukan(n)
		x=Array.new(7,0)
		unless n.nil?
			if 1<=n and n<=7
				x[n-1]= seibun[2]/80
			end
		end
		return x
	end

end

