#!/usr/local/bin/ruby -Ku
# encoding: utf-8

#$:.unshift File.join(File.dirname(__FILE__),"tool")
$:.unshift File.expand_path("tool", ENV['E_KEISAN'])
require 'tool'

def list_write(d,j,holder)
	i=0
	l=0
	while  i<d[0].length && j<d[1].length do
#		puts i
#		puts j-1
#		p d[1][j-1][3]
#		p d[0][i][0]
		if  d[0][i][1] !=  d[1][j-1][1]
			i=i+1
#			p "a"
			next
		elsif d[0][i][0]=="" 
 			if d[1][j-1][0]==""
				puts d[1][j-1].join(',')
			end
#			puts "bb"
			i=i+1
			l=l+1
#			p 'b'
			next
		else
#			p holder
#			p d[0][i][0]
			unless holder.include? d[0][i][0]
				d[1][j-1].shift
				d[1][j-1].unshift(d[0][i][0])
				puts d[1][j-1].join(',')
#				puts 'c'
			end
			i=i+1
			l=l+1
		end	
	end
	if l==0 && holder == []
		puts d[1][j-1].join(',')
#			puts "cc" 
	end
end

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
			if d[1][j+k][1]==d[1][j][1] 
				holder<< d[1][j+k][0]
				puts d[1][j+k].join(',')
#				puts "aa"
				if j+k+1 == d[1].length
					kk=k+1
					break
				end
			else
				kk=k
				break
			end		
		else
#			puts 'a' 
			kk=k
			break
		end
#		puts k
	end
#	puts 'b'
#	puts kk
	if kk==0 
		kk=1
	end
	j=j+kk

	list_write(d,j,holder)
end	


