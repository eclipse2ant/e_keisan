#!ruby -Ks
# encoding: Windows-31J


require 'file-win32'
require 'singleton'


module Worksheet
  def [] y,x
    self.Cells.Item(y,x).Value
  end
end


class SheetHolder
  include Singleton

	@sheet

	attr_accessor :sheet
end

module GoteiUtil
#Gotei_file='�v�Z���܂���@��ܒ������.xls'
Gotei_file='�v�Z���܂���@��ܒ�����ţ.xls'
#Gotei_file='�v�Z���܂���@��ܒ�����ţ.xlsx'

	def get_filename
		FileSystemObject.instance.getAbsolutePathName(Gotei_file)
	end

  def get_sheet(excel,filename)
		excel.Workbooks.Open({'filename'=> filename, 'readOnly' => true})
		sheet = excel.Worksheets.Item("�T���H�i�����\")
  	sheet.extend Worksheet
		return sheet	
	end

end

