#!/usr/local/bin/ruby -Ku
# encoding: utf-8

require 'csv'

#NUM=3
NUM=1

ARGV.each do |f|
  data=[]
	CSV.open(f,'r') do |csv|
		csv.each do |row|
		  data << row
 		end
	end
  i=0
  l=0
	while i < data.length-1  do
#    puts i
    clip=[]
    kk=0
    for k in 1..data.length-1 do
#       puts k
#      puts data[i+k].join(',')
			if data[i][NUM] == data[i+k][NUM]
#        puts data[i][NUM]
#        puts data[i+k][NUM]
        clip<<data[i+k-1]
#        p clip
        l=1
        kk=kk+1
      else 
        if clip!=[]
          clip<<data[i+k-1]
#          p 'a'
        end
        l=1
        kk=kk+1
#        p 'b'
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
end



