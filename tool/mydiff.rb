#!/usr/local/bin/ruby -Ku
# encoding: utf-8

require 'diff/lcs'
require 'diff/lcs/hunk'

def diff_as_string(data_old, data_new, format=:unified, context_lines=3)
	data_old = data_old.split(/\n/).map! { |e| e.chomp }
	data_new = data_new.split(/\n/).map! { |e| e.chomp }
	output = ""
	diffs = Diff::LCS.diff(data_old, data_new)
	return output if diffs.empty?
	oldhunk = hunk = nil
	file_length_difference = 0
	diffs.each do |piece|
		begin
			hunk = Diff::LCS::Hunk.new(data_old, data_new, piece,
												 context_lines,file_length_difference)
			file_length_difference = hunk.file_length_difference
			next unless oldhunk

			# Hunks may overlap, which is why we need to be careful when our
			# diff includes lines of context. Otherwise, we might print
			# redundant lines.

			if (context_lines > 0) and hunk.overlaps?(oldhunk)
				hunk.unshift(oldhunk)
			else
				output << oldhunk.diff(format)
			end
		ensure
			oldhunk = hunk
			output << "\n"
		end
	end
	#Handle the last remaining hunk
	output << oldhunk.diff(format) << "\n"
end

#s1 = "This is line one.\nThis is line two.\nThis is line three.\n"
#s2 = "This is line 1.\nThis is line two.\nThis is line three.\n" +
#"This is line 4.\n"

d=[]
ARGV.each do |f|
	File.open(f,'r') do |file|
		d << file.read
#		p d
	end	
end

#p d[0]

puts diff_as_string(d[0], d[1])

