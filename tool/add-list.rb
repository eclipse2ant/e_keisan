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
l=0
for j in 0...d[1].length-1 do
	unless d[1][j][0]==""
		hloder=[]
		for k in 0...d[1].length-(j+1)
			unless d[1][j+k][0]==""
				if d[1][j+k][0]==d[1][j]
					holder<< d[1][j+k][0]
					puts d[1][j+k].join(',')
					k++
				end
			end
			j=j+k
		end
		for i in 0...d[0].length-(l+1) do
			unless d[0][i+l][1]==d[1][j][4]
				i++
				next
			elsif d[0][i+l][0]==""
				i++
				next
			else
				unless holder.include? d[0][i+l][0]
					puts d[0][i+l].join(',')
				end
			end	
			l=i+1+l
		end
	end
end	


