#!/usr/local/bin/ruby -Ku
# encoding: utf-8

NUM=1
ARGF.each do |line|
  list=line.chop.split(',')
  print "#{list[0]},#{list[1]},#{list[2]},#{NUM},#{list[3]}\n"
end
