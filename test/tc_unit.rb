#!/usr/local/jruby/bin/jruby  
# encoding: utf-8

$:.unshift File.join(File.dirname(__FILE__),"..","lib")
require 'test/unit'
require 'unit' 

class TestUnit < Test::Unit::TestCase
  def test_simple
    assert_equal(50, Unit.new("50g").to_g)
    assert_equal(30, Unit.new("30g").to_g)
    assert_equal(30, Unit.new("30g").to_g("米"))
    assert_equal(30, Unit.new("大1").to_g("さとう"))
    assert_equal(50, Unit.new("大1").to_g("りんご"))
    assert_equal(50, Unit.new("大1個").to_g("りんご"))
    assert_equal(25, Unit.new("大1/2個").to_g("りんご"))
    assert_equal(50*(1.0/3), Unit.new("大1/3個").to_g("りんご"))
    assert_equal(50*1.2, Unit.new("大1.2個").to_g("りんご"))
#    assert_equal(50, Unit.new("大1").to_gram("大#個", "りんご"))
    assert_equal(0, Unit.new("適当").to_g("りんご"))
    assert_equal(0, Unit.new("適宜").to_g("水"))
		assert_raise(RuntimeError){Unit.new("大1個1").to_g("りんご")}
		assert_raise(RuntimeError){Unit.new("大1個").to_g("みかん")}
    assert_equal(200, Unit.new("200g").to_g("じゃがいも"))
  end
end
