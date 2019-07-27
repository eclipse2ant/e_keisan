#!/usr/local/jruby/bin/jruby  
# encoding: utf-8

$:.unshift File.expand_path("java-lib", ENV['E_KEISAN'])

require 'java'
require 'poi-3.8-20120326.jar'
require 'poi-ooxml-3.8-20120326.jar'
require 'poi-ooxml-schemas-3.8-20120326.jar'
require 'poi-scratchpad-3.8-20120326.jar'


java_import 'java.io.FileInputStream'
java_import 'org.apache.poi.hssf.usermodel.HSSFWorkbook'
java_import 'org.apache.poi.hssf.usermodel.HSSFSheet'
java_import 'org.apache.poi.hssf.usermodel.HSSFRow'
java_import 'org.apache.poi.hssf.usermodel.HSSFCell'
java_import 'org.apache.poi.ss.usermodel.Row'
java_import 'org.apache.poi.ss.usermodel.Cell'

#require 'file-win32'
require 'singleton'
require 'apath'

module Worksheet
  def [] y,x
#    self.Cells.Item(y,x).Value
    cell=self.getRow(y-1).getCell(x-1,Row.RETURN_BLANK_AS_NULL)
    if cell.nil? 
      return nil
    elsif
      type=cell.getCellType()
      if type == 0
        return cell.getNumericCellValue
      elsif type == 1
        return cell.getStringCellValue
      end
    end
  end
end


class SheetHolder
  include Singleton

	@sheet

	attr_accessor :sheet
end

module GoteiUtil

Gotei_file='nanatei-1.xlsx'

include Apath

  def get_filename
    FileInputStream.new(apath(Gotei_file))
  end

  def get_sheet(excel,filename)
    workBook= HSSFWorkbook.new(filename)
		sheet = workBook.getSheetAt(0)
  	sheet.extend Worksheet
		return sheet	
	end

end

