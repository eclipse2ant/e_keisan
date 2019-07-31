#!/usr/local/jruby/bin/jruby  
# encoding: utf-8


$:.unshift File.join(File.dirname(__FILE__),"..","lib")
require 'test/unit'
require 'recipe'

class TestRecipe < Test::Unit::TestCase

	def test_simple
		r = Recipe.new
		r.add("アマランサス", 50)
		r.add("ごはん", 300)
		r.add("これはテストです")
		assert_equal(358*0.5+168*3, r.energy)
		assert_equal("Sample recipe", r.name)
		assert_equal("アマランサス  50.0g\nごはん  300.0g\nこれはテストです", r.to_s)
		assert_equal(1,r.person)
		r1 = Recipe.new('Sample2',2)
		r1.add("アマランサス", 50)
		r1.add("ごはん", 300)
		r1.add("これはテストです")
		assert_equal(358*0.5+168*3, r1.energy)
		assert_equal((358*0.5+168*3)/2, r1.energy_per_person)
		assert_equal("Sample2", r1.name)
		assert_equal("アマランサス  50.0g\nごはん  300.0g\nこれはテストです", r1.to_s)
		assert_equal(2,r1.person)
		assert_equal(r1.energy,r1.v_seibun[0])
		assert_equal(r1.energy_per_person,r1.v_seibun_per_person[0])
		p r.energy_per_person
		p r1.energy_per_person
		puts r.to_s
		p r1.v_seibun
		p r1.v_seibun_per_person
	end
end
