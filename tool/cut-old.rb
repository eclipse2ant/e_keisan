#!/usr/local/bin/ruby -Ku
# encoding: utf-8


count=0
ARGF.each do |line|
  count+=1
  list=line.chop.split(',')
  print "#{list[3]},#{list[0]},#{list[5]},#{count}\n"
end
