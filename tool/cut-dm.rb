#!/usr/local/bin/ruby -Ku
# encoding: utf-8


count=0
ARGF.each do |line|
  count+=1
  list=line.chop.split(',')
  print "#{list[0]},#{list[1]},#{list[5]},#{list[6]}\n"
end
