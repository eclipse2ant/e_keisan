#!/usr/local/jruby/bin/jruby  
# encoding: utf-8


$:.unshift File.join(File.dirname(__FILE__),"..","lib")
#p $:
require 'test/unit'
require 'parser'
require 'jgotei_util'
require 'excel'
require 'apath'

class TestParser < Test::Unit::TestCase
	LinesSample=["ウインナー  60.0g\n", "玉ねぎ  30.0g\n", "献立1:\n", "じゃがいも  200.0g\n", "小麦粉  80.0g\n", "#水  0.0g\n", "トマト缶  100.0g\n", "にんにく  30.0g\n", "献立2:\n", "ウインナー  60.0g\n", "玉ねぎ  30.0g\n", "#オレガノ 適宜\n", "パルメザンチーズ  60.0g\n"]

	Pg_List=[["ウインナー  60.0g\n", "玉ねぎ  30.0g\n"], ["献立1:\n", "じゃがいも  200.0g\n", "小麦粉  80.0g\n", "#水  0.0g\n", "トマト缶  100.0g\n", "にんにく  30.0g\n"], ["献立2:\n", "ウインナー  60.0g\n", "玉ねぎ  30.0g\n", "#オレガノ 適宜\n", "パルメザンチーズ  60.0g\n"]]
include Apath

  def test_simple
		f=File.new(apath('pre_demo.txt'))
		x=Lines.new(f)
		pg_list=x.paragraphBuilder
	  r_list=pg_list.recipeBuilder
		assert_equal(LinesSample,x)
		assert_equal(Pg_List,pg_list)
		assert_equal('ウインナー',r_list[0].contents[0][0].name)
		p r_list[0].contents[0][0] 
		assert_equal(1343.0, r_list[0].contents[0][0].seibun[3])

	p r_list[0].contents[0][0].seibun[3]
  end

	include GoteiUtil

	def test_sheetholder
    filenames = get_filenames
    sheets=SheetHolders.instance.sheets
#      p sheets
     unless  sheets==nil        
      f=File.new('pre_demo.txt')
      x=Lines.new(f)
      pg_list=x.paragraphBuilder
      r_list=pg_list.recipeBuilder
      assert_equal(LinesSample,x)
      assert_equal(Pg_List,pg_list)
      assert_equal('ウインナー',r_list[0].contents[0][0].name)
      assert_equal(1343.0, r_list[0].contents[0][0].seibun[3])
     else
    	Excel.runDuring do |excel|
      	s=get_sheets(excel,filenames)
      	SheetHolders.instance.sheets=s
       	p s
      f=File.new('pre_demo.txt')
      x=Lines.new(f)
      pg_list=x.paragraphBuilder
      r_list=pg_list.recipeBuilder
      assert_equal(LinesSample,x)
      assert_equal(Pg_List,pg_list)
      assert_equal('ウインナー',r_list[0].contents[0][0].name)
      assert_equal(1343.0, r_list[0].contents[0][0].seibun[3])
    	end
		end
	end

	def test_parser
		r1=Parser.new().parse(File.new(apath('pre_demo.txt')))
		r2=Parser.new().parse(File.new(apath('sample/okara.txt')))
		r3=Parser.new().parse(File.new(apath('demo.txt')))
    assert_equal(1198.8,r1.energy)
		assert_equal(791.56,r2.energy_per_person.round(2))
		assert_equal(1198.8,r1.v_seibun[0])
		assert_equal(791.56,r2.v_seibun_per_person[0].round(2))

		p r1.v_seibun
		p r2.v_seibun_per_person
		p r3.v_seibun
		p r3.v_seibun_per_person

	end

end
