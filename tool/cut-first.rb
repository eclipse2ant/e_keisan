#!/usr/local/bin/ruby -Ku
# encoding: utf-8


count=0
ARGF.each do |line|
  list=line.chop.split(',')
#	p list[0]
	unless list[0]==''
  	puts "#{list[0]},#{list[3]}"
	end
end
