#!/usr/local/bin/ruby -Ku
# encoding: utf-8

#$:.unshift File.join(File.dirname(__FILE__),"tool")
$:.unshift File.expand_path("tool", ENV['E_KEISAN'])
require 'index_number'

#NUM=3
NUM=1

args = CatArguments.new(ARGV)

#p args[:index_number]
unless args[:index_number].nil?
	index_n=args[:index_number].to_i
else
	index_n=NUM
end

#p index_n 
#p ARGV


data = []
ARGF.each do |line|
	data << line.chop.split(',')
end

i=0
l=0
while i < data.length-1  do
# puts i
  clip=[]
	kk=0
  for k in 1..data.length-1 do
#		puts k
#   puts data[i+k].join(',')
		if data[i][index_n] == data[i+k][index_n]
#   	puts data[i][index_n]
#     puts data[i+k][index_n]
      clip<<data[i+k-1]
#     p clip
      l=1
      kk=kk+1
  	else 
    	if clip!=[]
    		clip<<data[i+k-1]
#     	p 'a'
   		end
  		l=1
    	kk=kk+1
#   	p 'b'
    	break
		end
	end
	i=i+kk
	if l==0
		i=i+1
	end
	clip.each do |s|
		puts s.join(',')
	end
end



