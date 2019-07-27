#!ruby -Ks 
# encoding: Windows-31J

$:.unshift File.join(File.dirname(__FILE__),"..","lib")
require 'gotei'
require 'test/unit'

class TestGotei < Test::Unit::TestCase
	def test_simple

		assert_equal("��", Gotei.new("��").record[3])
		assert_raise(RuntimeError){Gotei.new("��1").record[3]}

#		p Gotei.new("��").record

		assert_equal("���܂�񂳂�", Gotei.new("���܂�񂳂�").record[3])
		assert_equal("��������", Gotei.new("�R���f���X�~���N").record[5])

#		p Gotei.new("���܂�񂳂�").record
#		assert_equal("����", Names.new("��").custom_name)
#		assert_equal("����", Names.new("�����ނ�").custom_name)
	end
end
