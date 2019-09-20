#!/usr/local/jruby/bin/jruby  
# encoding: utf-8


require 'shokuhin'

module VectorUtil

	private

	def gen_null_vector
		x=[]
#		(0..68).each do 
#		(0..69).each do 
		(0..70).each do 
			x<< 0
		end 
		return Vector.elements(x)
	end

end
 

class Recipe

	include VectorUtil

	def initialize(name="Sample recipe",person=1)
		@name = name
		@contents = []
		@person=person
		@@null=gen_null_vector
	end

	def add(sname, qty=nil)
		if qty == nil
			@contents << sname
		else
			begin
				shokuhin = Shokuhin.new(sname)
			rescue
				raise
			end
#			p shokuhin.name
#			p qty
			@contents << [shokuhin, qty.to_f]
#			p @contents
		end
	end

	def energy
		energy =  0
		@contents.each do |shokuhin, qty|
			if qty == nil
				next
			elsif shokuhin.seibun[2] == nil 
				next
			else
				energy += shokuhin.seibun[2]*(qty/100)
			end
		end	
		return energy
	end


	def v_seibun
		v=@@null
		@contents.each do |shokuhin, qty|
			if qty == nil
				next
			else
#				p v.size
#				p shokuhin.v_seibun.size
				v = v+shokuhin.v_seibun*(qty/100)
			end
		end	
		return v
	end

	def energy_per_person
		energy/(@person.to_f)
	end


	def v_seibun_per_person
		v_seibun*((@person.to_f)**(-1))
	end

	def to_s
		tmp=[]
		@contents.each do |shokuhin, qty|
			if qty == nil
				 tmp<<shokuhin
				next
			else
				tmp<< "#{shokuhin.name}  #{qty}g"
				next
			end
		end
	tmp.join("\n")
	end
	attr_reader :name, :contents, :person


end
