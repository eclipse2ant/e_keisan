import openpyxl
import pprint

wb=openpyxl.load_workbook('sample.xlsx')
sheet=wb.active
for cell_obj in list(sheet.rows)[1]:
	print(cell_obj.value)
