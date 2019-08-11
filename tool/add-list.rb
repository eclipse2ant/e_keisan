#!/usr/local/bin/ruby -Ku
# encoding: utf-8

#$:.unshift File.join(File.dirname(__FILE__),"tool")
$:.unshift File.expand_path("tool", ENV['E_KEISAN'])
require 'tool'

d=[]
ARGV.each do |f|
	data = read_file(f)
	d<< data
end
for j in 0...d[1].length-1 do
	unless d[1][j][0]==""
		puts d[1][j].join(',')
		j++
		next
	else
		for i in 0...d[0].length-1 do
			unless d[0][i][1]==d[1][j][4]
				i++
				next
			elsif d[0][i][0]==""
				i++
				next
			else
				holder=[]
				for k in 0...d[0].length-(i+1) do
					holder<<d[0][i+k][1]
				end
				unless holder.include? d[1][j]
					puts d[0][	
		end
	end
end	


