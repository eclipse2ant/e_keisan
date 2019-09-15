#!/usr/local/jruby/bin/jruby -W0  
# encoding: utf-8


#$:.unshift File.join(File.dirname(__FILE__),"lib")
$:.unshift File.expand_path("lib", ENV['E_KEISAN'])
require 'parser'


SEIBUN_NAME=
[
 'DM表','廃棄率','エネルギー(kcal)','エネルギー(kj)','水分','タンパク','アミノ酸組成によるタンパク質','脂質','トリグリセロール当量','飽和脂肪酸',\
\
'一価飽和脂肪酸','多価不飽和脂肪酸','コルステロール','炭水化物','利用可能炭水化物','水溶性食物繊維','不溶性食物繊維','食物繊維総量','灰分','ナトリウム', \
\
'カリウム','カルシウム','マグネシウム','リン','鉄','亜鉛','銅','マンガン','ヨウ素','セレン',\
\
'クロム','モリブデン','レチノール','α-カロテン','β-カロテン','β-クリプトキサン','β-カロテン当量','レチノール活性当量','ビタミンD','α-トコフェロール', \
\
'βトコフェロールル','Γ-トコフェロール','δ-トコフェロー','ビタミンK','ビタミンB1','ビタミンB2','ナイアシン','ナイアシン当量','ビタミンB6','ビタミン12','葉酸',\
\
'パントテン酸','ビオチン','ビタミンC', '食塩相当量','アルコール','硫酸イオン','テオブロミン','カフェイン','タンニン','ポリフェノール',\
\
'酢酸','調理油','有機酸','重量変化率'
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
			print "(塩分;#{recipe.v_seibun_per_person[52].roundoff(1)}g)" 
			print "\n" 
		print "(DM交換表; #{recipe.v_seibun_per_person.roundoff(1).to_a[62..68].join(' ')})" 
			print "\n\n"
		end
		puts "Total:#{@r_list.energy.roundoff(1)} kcal (#{@r_list.energy_per_person.roundoff(1)} kcal)"
	puts ""
		print "(タンパク質;#{@r_list.v_seibun_per_person[3].roundoff(1)}g)" 
		print "(塩分;#{@r_list.v_seibun_per_person[52].roundoff(1)}g)"
		print "\n" 
		print "(DM交換表; #{@r_list.v_seibun_per_person.roundoff(1).to_a[62..68].join(' ')})" 
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
#  check_usage 
	Manager.new().run
end

