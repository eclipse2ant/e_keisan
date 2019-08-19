#!/usr/local/bin/ruby -Ku
# encoding: utf-8

#$:.unshift File.join(File.dirname(__FILE__),"tool")
$:.unshift File.expand_path("tool", ENV['E_KEISAN'])
require 'addlist'
require 'optparse'

NUM=1

class CatArguments < Hash
	def initialize(args)
		super()
		opts = OptionParser.new do |opts|
			opts.banner = "Usage: #$0 [options]"
			opts.on('-n', '--number [NUMBER]', 'field index number') do |number|
				self[:index_number] = number
#				p number
			end
			opts.on('-p', '--preview', 'preview adding lines') do
				self[:preview] = true
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

#p index_n 
#p ARGV


d=[]
ARGV.each do |f|
	data = read_file(f)
	d<< data
end

add_list(args,d,index_n)


