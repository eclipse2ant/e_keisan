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
j=0
while  j < d[1].length do
	holder=[]
	kk=0
	for k in 0..d[1].length-(j+1) do
		unless  d[1][j+k][0]==""
#			puts  d[1][j+k][0] 
			if d[1][j+k][0]==d[1][j][0] 
				holder<< d[1][j+k][0]
				puts d[1][j+k].join(',')
			end		
		else
#			puts 'a' 
			kk=k
			break
		end
#		puts k
	end
#	puts 'b'
	if kk==0 
		kk=1
	end
	j=j+kk
	i=0
	while  i<d[0].length-l do
		puts i
		puts j
		p d[1][j][3]
		p d[0][i+l][3]
		if  d[0][i+l][3]!=d[1][j][3]
			i=i+1
			next
		elsif d[0][i+l][0]==""
			i=i+1
			next
		else
			unless holder.include? d[0][i+l][0]
				puts d[0][i+l].join(',')
			end
		end	
		l=i+l
	end
end	


