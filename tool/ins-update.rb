#!/usr/local/bin/ruby -Ku
# encoding: utf-8

#$:.unshift File.join(File.dirname(__FILE__),"tool")
$:.unshift File.expand_path("tool", ENV['E_KEISAN'])
#require 'insupdate'
require 'optparse'
require "tool"

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
			opts.on('-p', '--preview', 'preview update lines') do
				self[:preview] = true
			end
			opts.on('-u', '--update', 'update items') do
				self[:update] = true
			end
			opts.on('-i', '--insert', 'insert item') do
				self[:insert] = true
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


def write_list(d)
  d.each do |list|
    puts list.join(',')
  end
end

def ins_update(args,d,m)
  i=0
	j=0
  holder=[]
  for i in 0..d[0].length-1 do
    l=0
    for j in 0..d[1].length-1 do
			if d[1][j][m]==d[0][i][m]
        if args[:update]==true
          puts d[0][i].join(',')
        end
        k=0
        for k in 2..4 do 
				  d[1][j][k]=d[0][i][k]
        end
        if args[:preview]==true
				  puts d[1][j].join(',')
        end
        l=l+1
      end
    end
    if l==0
      holder << d[0][i]
      if args[:insert]==true
        puts d[0][i].join(',')
      end
    end
  end
  if args[:preview]!=true && args[:update]!=true && args[:insert]!=true
    write_list(d[1])
    write_list(holder)
  end
end
          


d=[]
ARGV.each do |f|
	data = read_file(f)
	d<< data
end
ins_update(args,d,index_n)


