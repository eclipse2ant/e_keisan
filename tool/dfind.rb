#!/usr/local/bin/ruby -Ku
# encoding: utf-8

require 'csv'
#require 'jcode'

#NUM=3
NUM=1

def check_usage   
  if ARGV.length == 0 
		puts "Usage: #{File.basename($0)} filename"
    exit
  end
end

def run
  ARGV.each do |f|
  	data=[]
		CSV.open(f,'r') do |csv|
			csv.each do |row|
		  	data << row
 			end
		end
		for i in 0..data.length-2 do
			unless data[i][NUM]==nil 
				if data[i][NUM] == data[i+1][NUM]
					puts data[i].join(",")
					if i==data.length-2 || data[i+1]!=data[i+2]
						puts data[i+1].join(",")
					end
				end
			end
		end
	end
end


if $0 == __FILE__ 
#  check_usage 
	run
end

