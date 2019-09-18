#!/usr/local/jruby/bin/jruby  
# encoding: utf-8


$:.unshift File.join(File.dirname(__FILE__),"lib")
require 'excel'
require 'recipe'
require 'jgotei_util'
require 'unit'

class Numeric
  def roundup(d=0)
    x = 10**d
    if self > 0
      (self * x).ceil.quo(x)
    else
      (self * x).floor.quo(x)
    end
  end

  def rounddown(d=0)
    x = 10**d
    if self < 0
      (self * x).ceil.quo(x)
    else
      (self * x).floor.quo(x)
    end
  end

  def roundoff(d=0)
    x = 10**d
    if self < 0
      (self * x - 0.5).ceil.quo(x).to_f
    else
      (self * x + 0.5).floor.quo(x).to_f
    end
  end
end


class Vector
	def roundoff(d=0)
		self.map {|x| x.roundoff(d)}
	end
end

module Line
unless RUBY_VERSION >= '1.9.0'
	require 'jcode'
end

	def z2h(line)
		line.gsub!('　',' ')
		line.gsub!('／','/')
		line.gsub!('．','.')
		line.gsub!('，',',')
		line.gsub!('％','%')
		line.gsub!('＊','*')
		line.gsub!('＠','@')
		line.gsub!('＋','+')
		line.gsub!('−','-')
#		line.gsub!('¥','\\')
		line.gsub!('^','^')
		line.gsub!('＃','#')
		line.gsub!('＄','$')
		line.gsub!('＝','=')
		line.gsub!('＿','_')
		line.gsub!('？','?')
		line.gsub!('！','!')
		line.gsub!('（','(')
		line.gsub!('）',')')
		line.gsub!('：',':')
		line.gsub!('［','[')
		line.gsub!('］',']')
		line.tr!("０-９","0-9")
    if  RUBY_VERSION >= '1.9.0'
#  		line.tr!('ｍ','m')
#  		line.tr!('ｌ','l')
#  		line.tr!('ｇ','g')
#	  	line.tr!('ｃ','c')
		  line.tr!("Ａ-Ｚ","A-Z")
		  line.tr!("ａ-ｚ","a-z")
    else
		  line.tr!("Ａ-ｚ","A-z")
    end
		return line
	end

	def u2g(line)
		unless /^#/ =~ line
			sname, qty = line.chomp.split
#			p sname
			unless  qty == nil
				begin
					line= "#{sname}  #{Unit.new(qty).to_g(sname)}g\n"
#					p Unit.new(qty).to_g(sname)
				rescue
					$stderr.print  $!
					exit
				end
			end
		end
		return line
	end

end



class List < Array

	def initialize(f)
		super()
		build(f)
	end

#attr_reader :list

end

class Lines < List

	include Line

	def build(f)
		begin
			f.each do |ln|
				unless /^\s*\n$/ =~ ln
#					p z2h(ln)
					ln=u2g(z2h(ln))
#					p ln
					self << ln 
				end
			end
		rescue
			$stderr.print  $!
      puts "\n"
			exit
		end
	end


	def paragraphBuilder
		return ParagraphList.new(self)
	end

end



class ParagraphList < List

	def recipeBuilder
		return RecipeList.new(self)
	end

	private

	def put_paragraph
		self << @item
		@item=[]
	end

	def build(f)
		@item=[]
		f.each do |ln|
			if ln=~ /^(.*):/ 
				unless @item == []
					put_paragraph
				end
				@item << ln
				next
			else			
				@item << ln
				next
			end
		end
		put_paragraph
	end				
			


end


class RecipeList < List

	include VectorUtil
	
	def initialize(f)
		super(f)
		@@null=gen_null_vector
	end

	def build(f)
		f.each do |pg|		
#			p pg
			r=buildRecipe(pg)
			self << r
		end
#		return self
	end

	def buildRecipe(f)
		ln=f[0]
		if /^(.*):/ =~ ln 
			ln=$1
			if /\[(\d+)\]$/ =~ ln
				r=Recipe.new(ln,$1)
			else
				r=Recipe.new(ln)
			end
		else
			r=Recipe.new()
		end
		f.each do |ln|
			subst(r,ln)
		end
		return r
	end

	def energy
		sum=0
		self.each do |recipe|
			sum+=recipe.energy
		end
		return sum
	end


	def v_seibun
		sum=@@null
		self.each do |recipe|
			sum=sum+recipe.v_seibun
		end
		return sum
	end


	def energy_per_person
		sum=0
		self.each do |recipe|
			sum+=recipe.energy_per_person
		end
		return sum
	end

	def v_seibun_per_person
		sum=@@null
		self.each do |recipe|
			sum=sum+recipe.v_seibun_per_person
		end
		return sum
	end


	private

	def subst(r,ln)
		if /^\s*#/ =~ ln
			r.add(ln.chomp)
		else 
			sname, qty = ln.chomp.split
			begin
				r.add(sname,qty)
			rescue
				$stderr.print  $!
				exit
			end
		end
	end

end


class Parser

	include GoteiUtil

	def parse(f=ARGF)
    filenames=get_filenames
		recipe_list=nil
    sheets=SheetHolders.instance.sheets
#      p sheets
     unless  sheets==nil        
      recipe_list=Lines.new(f).paragraphBuilder.recipeBuilder
     else
    	Excel.runDuring do |excel|
      	s=get_sheets(excel,filenames)
      	SheetHolders.instance.sheets=s
      	recipe_list=Lines.new(f).paragraphBuilder.recipeBuilder
    	end
		end
	  recipe_list
	end



end




