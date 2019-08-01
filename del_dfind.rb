#!/usr/local/bin/ruby -Ku
# encoding: utf-8

require 'csv'
#require 'jcode'


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
		unless data[0][0]==nil
			puts data[0].join(",") 
			for i in 1..data.length-2 do
				unless data[i][0]==nil
					if data[i][0] != data[i-1][0]
						puts data[i].join(",")
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

