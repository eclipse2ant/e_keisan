#!/usr/local/jruby/bin/jruby  
# encoding: utf-8

#############################################################################
###  単位の編集(@@u2fの編集)は、unit_file.rb で行ってください　##############
#############################################################################


require 'apath'
require 'unit_file'

class Unit

include Apath




def initialize(qty)
  @rep = qty
end

def to_g(shokuhin = nil)
  if @rep =~ /^(\D*)(\d+)([\/.])(\d+)(\D*)$/
    if $3 == '/'
      @amount =$2.to_f / $4.to_f
    else
      @amount = "#{$2}.#{$4}".to_f
    end
#    p @amount
    if $5 == 'g'
      return @amount
    else @amount*to_gram("#{$1}##{$5}", shokuhin)
    end
  elsif @rep =~ /^(\D*)(\d+)(\D*)$/  
    @amount = $2.to_f
    if $3 == 'g'
      return @amount
    else
      return @amount*to_gram("#{$1}##{$3}", shokuhin)
    end
  elsif @rep =~ /^(\D+)$/
    return to_gram("#{$1}", shokuhin)
  else raise "単位のパターンが一致しません"
  end
end

def to_gram(unit, shokuhin)
#	p unit
#	p shokuhin
	if @@u2f[unit] == nil
		raise "#{unit} に対応するファイルが見つかりません\n"
	end
  File.foreach(apath("lib/units/#{@@u2f[unit]}")) do |line|
  	s, gram = line.chomp.split(',')
#   p s
   	if s  == shokuhin
      return gram.to_f
    end
  end
	raise "単位 #{unit} に対応する #{shokuhin} がありません\n"
end
end
