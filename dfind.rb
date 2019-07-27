#!ruby -Ks
# encoding: Windows-31J

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
			CSV.open(f,'r') do |row|
				data << row
			end
			for i in 0..data.length-2 do
				if data[i][0] == data[i+1][0]
					p data[i][0..5]
					p data[i+1][0..5]
				end
			end
	end
end



if $0 == __FILE__ 
  check_usage 
	run
end



