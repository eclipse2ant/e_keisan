#!ruby -Ks

def check_usage   # (1)
  unless ARGV.length == 2 
    puts "Usage: #{File.basename($0)} file1 file2"
    exit
  end
end


class Mydiff

	def initialize(old,new)
		in_p=IO.popen("diff -u #{old} #{new}",'r')
		f=open('diff.txt','w')
		#while s=in_p.gets
		in_p.collect  do |s|
			f.puts s
		end
		f.close
#		puts File.size('diff.txt')
	end


	def	result
		return File.size('diff.txt')
	end
end



if $0 == __FILE__ 
  check_usage 
  Mydiff.new(ARGV[0], ARGV[1]).result 
end
