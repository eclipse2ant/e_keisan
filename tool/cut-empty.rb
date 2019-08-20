#!/usr/local/bin/ruby -Ku
# encoding: utf-8

#$:.unshift File.join(File.dirname(__FILE__),"tool")
$:.unshift File.expand_path("tool", ENV['E_KEISAN'])
require 'optparse'



NUM=0


class CatArguments < Hash
	def initialize(args)
		super()
		opts = OptionParser.new do |opts|
			opts.banner = "Usage: #$0 [options]"
			opts.on('-n', '--number [NUMBER]', 'field index number') do |number|
				self[:index_number] = number
#				p number
			end
			opts.on('-r', '--revrse', 'output empty fields') do 
				self[:reverse] = true
			end
			opts.on_tail('-h', '--help', 'display this help and exit') do
				puts opts
				exit
			end
		end
    begin
      opts.parse!(args)
    rescue
      $stderr.puts  $!
    end
	end
end


args = CatArguments.new(ARGV)

#p args[:index_number]
unless args[:index_number].nil?
	index_n=args[:index_number].to_i
else
	index_n=NUM
end





ARGF.each do |line|
  list=line.chop.split(',')

#		p args[:reverse]
		if args[:reverse] == true
		if list[index_n]==""
		puts list.join(',')
		end
	else
		unless list[index_n]==""
			puts list.join(',')
		end
	end
end
