#!/usr/local/jruby/bin/jruby -W0  
# encoding: utf-8


#$:.unshift File.join(File.dirname(__FILE__),"lib")
$:.unshift File.expand_path("lib", ENV['E_KEISAN'])
require 'parser'


SEIBUN_NAME=
[
 'DM表','廃棄率','エネルギー','kj','水分','タンパク','脂質','炭水化物','灰分','ナトリウム', \
\
'カリウム','カルシウム','マグネシウム','リン','鉄','亜鉛','銅','レチノール','カロテン', \
\
'レチノール当量','VD','VE','VK','VB1','V.B2','ナイアシン','B6','B12','葉酸','パントテン酸','V.C', \
\
'飽和脂肪酸','１価不飽和','多価不飽和','コレステロール','水溶性繊維','不溶性繊維','総和','食塩相当量'
]

def check_usage   
  if ARGV.length == 0 
		
    puts "Usage: #{File.basename($0)} filename"
    exit
  end
end


class View
	def initialize(r_list)
		@r_list=r_list
	end

	def to_s
		puts ""
		@r_list.each do |recipe|
			puts recipe.to_s
			puts "----------------------------------"
			puts "#{recipe.energy.roundoff(1)} kcal (#{recipe.energy_per_person.roundoff(1)} kcal)" 
			puts ""
			print"(タンパク質;#{recipe.v_seibun_per_person[3].roundoff(1)}g)" 
			print "(塩分;#{recipe.v_seibun_per_person[36].roundoff(1)}g)" 
			print "\n" 
			print "(DM交換表; #{recipe.v_seibun_per_person.roundoff(1).to_a[37..43].join(' ')})" 
			print "\n\n"
		end
		puts "Total:#{@r_list.energy.roundoff(1)} kcal (#{@r_list.energy_per_person.roundoff(1)} kcal)"
		puts ""
		print "(タンパク質;#{@r_list.v_seibun_per_person[3].roundoff(1)}g)" 
		print "(塩分;#{@r_list.v_seibun_per_person[36].roundoff(1)}g)"
		print "\n" 
		print "(DM交換表; #{@r_list.v_seibun_per_person.roundoff(1).to_a[37..43].join(' ')})" 
		print "\n\n"
#		p @r_list.v_seibun_per_person
#		p SEIBUN_NAME.length
	end
end

class Manager

	def run
		recipe_list=Parser.new().parse
		View.new(recipe_list).to_s
	end
end


if $0 == __FILE__ # (3)
  check_usage 
	Manager.new().run
end

