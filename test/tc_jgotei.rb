#!/usr/local/jruby/bin/jruby  
# encoding: utf-8

$:.unshift File.join(File.dirname(__FILE__),"..","lib")
require 'jgotei'
require 'test/unit'

class TestGotei < Test::Unit::TestCase
  def test_simple
    Gotei.new("米")
#   assert_equal('1','1')
		assert_equal("こめ　［水稲穀粒］　精白米　うるち米　", Gotei.new("米").record[3])
		assert_raise(RuntimeError){Gotei.new("米1").record[3]}

		p Gotei.new("米").record

	assert_equal("アマランサス　玄穀　", Gotei.new("アラマンサス").record[3])
		assert_equal("＜牛乳及び乳製品＞（練乳類）　加糖練乳　　　", Gotei.new("コンデンスミルク").record[3])
	p Gotei.new("コンデンスミルク").record 
		p Gotei.new("アラマンサス").record
		assert_equal(1083,  Gotei.new("米").record[1].to_i)
		assert_equal(1006, Gotei.new("押麦").record[1].to_i)
		assert_equal(18022, Gotei.new("フライ済み冷凍ミンチカツ").record[1].to_i)
		p Gotei.new("フライ済み冷凍ミンチカツ").record[3]
	end
end
