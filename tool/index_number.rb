#!/usr/local/bin/ruby -Ku
# encoding: utf-8

#$:.unshift File.join(File.dirname(__FILE__),"tool")
$:.unshift File.expand_path("tool", ENV['E_KEISAN'])
require 'optparse'

class CatArguments < Hash
	def initialize(args)
		super()
		opts = OptionParser.new do |opts|
			opts.banner = "Usage: #$0 [options]"
			opts.on('-n', '--number [NUMBER]', 'field index number') do |number|
				self[:index_number] = number
#				p number
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


