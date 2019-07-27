#!ruby -Ks
$:.unshift File.join(File.dirname(__FILE__),"lib")
require 'excel'
require 'recipe'
require 'gotei_util'
require 'unit'



module Line
require 'jcode'

	def z2h(line)
		line.gsub!('@',' ')
		line.gsub!('^','/')
		line.gsub!('D','.')
		line.gsub!('C',',')
		line.gsub!('“','%')
		line.gsub!('–','*')
		line.gsub!('—','@')
		line.gsub!('{','+')
		line.gsub!('|','-')
#		line.gsub!('','\\')
		line.gsub!('^','^')
		line.gsub!('”','#')
		line.gsub!('','$')
		line.gsub!('','=')
		line.gsub!('Q','_')
		line.gsub!('H','?')
		line.gsub!('I','!')
		line.gsub!('i','(')
		line.gsub!('j',')')
		line.gsub!('F',':')
		line.tr!("‚O-‚X","0-9")
		line.tr!("‚`-‚š","A-z")
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
					ln=u2g(z2h(ln))
#					p ln
					self << ln 
				end
			end
		rescue
			$stderr.print  $!
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
		filename = get_filename
		recipe_list=nil
		Excel.runDuring do |excel|
			s=get_sheet(excel,filename)
			SheetHolder.instance.sheet=s
			recipe_list=Lines.new(f).paragraphBuilder.recipeBuilder
		end
	recipe_list
	end

end




