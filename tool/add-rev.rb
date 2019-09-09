#!/usr/local/bin/ruby -Ku
# encoding: utf-8

#$:.unshift File.join(File.dirname(__FILE__),"tool")
$:.unshift File.expand_path("tool", ENV['E_KEISAN'])
require 'optparse'


NUM=1

class CatArguments < Hash
	def initialize(args)
		super()
		opts = OptionParser.new do |opts|
			opts.banner = "Usage: #$0 [options]"
			opts.on('-n', '--number [NUMBER]', 'revision number') do |revision|
				self[:revision] = revision
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

args = CatArguments.new(ARGV)

#p args[:revision]
unless args[:revision].nil?
	rev=args[:revision].to_i
else
	rev=NUM
end


ARGF.each do |line|
  list=line.chop.split(',')
  print "#{list[0]},#{list[1]},#{list[2]},#{rev},#{list[3]}\n"
end
