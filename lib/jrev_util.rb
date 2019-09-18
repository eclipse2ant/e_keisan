#!/usr/local/jruby/bin/jruby  
# encoding: utf-8

$:.unshift File.expand_path("java-lib", ENV['E_KEISAN'])

require 'java'
require 'commons-collections4-4.1.jar'
#require 'commons-compress-1.18.jar' 
require 'poi-3.17.jar'
require 'poi-ooxml-3.17.jar'
require 'poi-ooxml-schemas-3.17.jar'
require 'poi-scratchpad-3.17.jar'
require 'poi-excelant-3.17.jar'
require 'xmlbeans-2.6.0.jar'

java_import 'java.io.FileInputStream'
java_import 'java.io.FileOutputStream'
java_import 'org.apache.poi.hssf.usermodel.HSSFWorkbook'
java_import 'org.apache.poi.hssf.usermodel.HSSFSheet'
java_import 'org.apache.poi.hssf.usermodel.HSSFRow'
java_import 'org.apache.poi.hssf.usermodel.HSSFCell'
java_import 'org.apache.poi.hssf.util.HSSFColor'


java_import 'org.apache.poi.ss.usermodel.BorderStyle'
java_import 'org.apache.poi.ss.usermodel.FillPatternType'
java_import 'org.apache.poi.ss.usermodel.HorizontalAlignment'
java_import 'org.apache.poi.ss.usermodel.IndexedColors'
java_import 'org.apache.poi.xssf.usermodel.XSSFCell'
java_import 'org.apache.poi.xssf.usermodel.XSSFCellStyle'
java_import 'org.apache.poi.xssf.usermodel.XSSFFont'
java_import 'org.apache.poi.xssf.usermodel.XSSFRow'
java_import 'org.apache.poi.xssf.usermodel.XSSFSheet'
java_import 'org.apache.poi.xssf.usermodel.XSSFWorkbook'


#require 'file-win32'
require 'singleton'
require 'apath'

module Worksheet
  def [] y,x
    cell=self.getRow(y-1).getCell(x-1)
#   cell=self.getRow(y-1).getCell(x-1,RETURN_BLANK_AS_NULL)
#   p cell
    if cell.nil? 
      return nil
    elsif
      type=cell.getCellType()
#      p type
      if type == 0
        return cell.getNumericCellValue
      elsif type == 1 
        return trans(cell.getStringCellValue)
      end
    end
  end

	def []= y,x,v
		row = self.getRow(y-1)
		if row.nil?
			row = self.createRow(y-1)
		end
    cell=row.getCell(x-1)
    if cell.nil? 
			cell = row.createCell(x-1)
		end
		cell.setCellValue(v)
	end

	def	trans(s)
		if s =~ /Tr/ || s =~ /-/
			return 0
		elsif s =~ /\(*(\d+)\.(\d+)\)*/
			return "#{$1}.#{$2}".to_f
		elsif s =~ /\(*(\d+)\)*/
			return "#{$1}".to_i
		else return s
		end
	end

end


class SheetHolder
  include Singleton

	@sheet

	attr_accessor :sheet
end

module RevUtil

include Apath

  def get_filename(f)
    FileInputStream.new(apath(f))
  end

  def get_workbook(filename)
    XSSFWorkbook.new(filename)
  end    

  def get_sheet(wb)
      sheet = wb.getSheetAt(0)
#    p sheet
    sheet.extend Worksheet
    return sheet	
  end

  def put_filename(f)
    FileOutputStream.new(apath(f) , true)
  end


end

