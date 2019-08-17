#!/usr/local/bin/ruby -Ku
# conding utf-8

require 'optparse'

class GrepArguments < Hash
	def initialize(args)
		super()
		opts = OptionParser.new do |opts|
			opts.banner = "Usage: #$0 [options]"
			opts.on('-n') do 
				self[:number] = true
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

args = GrepArguments.new(ARGV)

str=ARGV.shift
reg=Regexp.new(str)
begin
	ARGF.each do |line|
  	if reg =~ line
			if args[:number]
   			print "#{ARGF.filename} #{ARGF.file.lineno}: #{line}"
			else
    	print "#{line}"
			end
  	end
	end
rescue
$stderr.print  $!
end
