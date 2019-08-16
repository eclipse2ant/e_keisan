#!/usr/local/bin/ruby -Ku
# encoding: utf-8


ARGF.each do |line|
  list=line.chop.split(',')
	unless list[0]==""
		puts list.join(',')
	end
end
