#!/usr/local/jruby/bin/jruby  
# encoding: utf-8


$:.unshift File.join(File.dirname(__FILE__),"..","test")

# file ts_e_keisan.rb

require 'test/unit'
require 'tc_jgotei'
require 'tc_shokuhin'
require 'tc_recipe'
require 'tc_unit'
require 'tc_parser'
