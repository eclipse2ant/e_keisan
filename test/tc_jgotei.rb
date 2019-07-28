#!/usr/local/jruby/bin/jruby  
# encoding: utf-8

$:.unshift File.join(File.dirname(__FILE__),"..","lib")
require 'jgotei'
require 'test/unit'

class TestGotei < Test::Unit::TestCase
  def test_simple
    Gotei.new("米")
#   assert_equal('1','1')
#		assert_equal("米", Gotei.new("米").record[3])
#		assert_raise(RuntimeError){Gotei.new("米1").record[3]}

#		p Gotei.new("米").record

#		assert_equal("あまらんさす", Gotei.new("あまらんさす").record[3])
#		assert_equal("加糖練乳", Gotei.new("コンデンスミルク").record[5])

#		p Gotei.new("あまらんさす").record
#		assert_equal("こめ", Names.new("米").custom_name)
#		assert_equal("押麦", Names.new("おしむぎ").custom_name)
	end
end
