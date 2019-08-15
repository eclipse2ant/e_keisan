#!/usr/local/bin/ruby -Ku
# conding utf-8

def check_usage   
  if ARGV.length == 0 
    puts "Usage: #{File.basename($0)}  keyword  filename"
    exit
  end
end


check_usage
str=ARGV.shift
str_u=str.encode("UTF-8")
reg=Regexp.new(str_u)
begin
	ARGF.each do |line|	
#  	if line =~ /#{str}/
  	if reg =~ line.encode
#   	print "#{ARGF.filename} #{ARGF.file.lineno}: #{line}"
    	print "#{line}"
  	end
	end
rescue
$stderr.print  $!
end
