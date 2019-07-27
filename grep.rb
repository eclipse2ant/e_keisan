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
reg=Regexp.new(str)
begin
	ARGF.each do |line|
#  	if line =~ /#{str}/
  	if reg =~ line
#   	print "#{ARGF.filename} #{ARGF.file.lineno}: #{line}"
    	print "#{line}"
  	end
	end
rescue
$stderr.print  $!
end
