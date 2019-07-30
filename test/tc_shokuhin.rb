#!/usr/local/jruby/bin/jruby  
# encoding: utf-8

$:.unshift File.join(File.dirname(__FILE__),"..","lib")
require 'shokuhin'
require 'test/unit'

class TestShokuhin < Test::Unit::TestCase
	Kome_exact = "こめ　［水稲穀粒］　精白米　うるち米　"
	Kome_seibun = [1,0.0, 358.0, 1498.0, 14.9, 6.1, 5.2, 0.9, 0.8, 0.29, 0.21, 0.31, 0, 77.6, 83.1, 0, 0.5, 0.5, 0.4, 1.0, 89.0, 5.0, 23.0, 95.0, 0.8, 1.4, 0.22, 0.81, 0, 2.0, 0, 69.0, 0, 0, 0, 0, 0, 0, 0, 0.1, 0, 0, 0, 0, 0.08, 0.02, 1.2, 0.12, 0, 12.0, 0.66, 1.4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	Amaran_seibun=[1.0, 0.0, 358.0, 1498.0, 13.5, 12.7, 6.0, 64.9, 2.9, 1.0, 600.0, 160.0, 270.0, 540.0, 9.4, 5.8, 0.92, 0.0, 0.0, 0.0, 0.0, 2.3, 0.0, 0.04, 0.14, 1.0, 0.58, 0.0, 130.0, 1.69, 0.0, 1.18, 1.47, 2.1, 0.0, 1.1, 6.3, 7.4, 0.0]

	def test_simple
		assert_raise(RuntimeError){Shokuhin.new("米1").name}
		assert_equal(1083, Shokuhin.new("米").number)
		assert_equal("米", Shokuhin.new("米").name)
		assert_equal(Kome_exact, Shokuhin.new("米").exact_name)
		p Shokuhin.new("米").seibun
		assert_equal(1,Shokuhin.new("米").dm)
		assert_equal(4,Shokuhin.new("コンデンスミルク").dm)
		assert_equal(Kome_seibun, Shokuhin.new("米").seibun)
		assert_equal("おしむぎ", Shokuhin.new("おしむぎ").name)
		assert_equal("コンデンスミルク", Shokuhin.new("コンデンスミルク").name)
		assert_equal("バター",Shokuhin.new("バター").name)
#		p Shokuhin.new("バター").exact_name
#		assert_equal("押麦", Shokuhin.new("おしむぎ").custom_name)
#		assert_equal(Amaran_seibun, Shokuhin.new("あまらんさす").seibun)
#p		Shokuhin.new("バター")
#p		Shokuhin.new("おしむぎ")
#p		Shokuhin.new("米").name
#p		Shokuhin.new("米").custom_name
#p		Shokuhin.new("米").exact_name
p			Shokuhin.new("米").seibun
#p			Shokuhin.new("あまらんさす").seibun
#			Shokuhin.new("アイスクリーム").seibun
#			Shokuhin.new("ソフトクリーム").seibun
#p			Shokuhin.new("みず").seibun
	end

#	def test_v_seibun
#p		Shokuhin.new("アイスクリーム").v_seibun
#p		Shokuhin.new("米").v_seibun
#p 		Shokuhin.new("水").v_seibun
#	end
end
