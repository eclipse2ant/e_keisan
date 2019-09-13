import openpyxl
import pprint

wb1=openpyxl.load_workbook('b3.xlsx')
wb2=openpyxl.load_workbook('nanatei-1.xlsx')
sheet1=wb1.active
sheet2=wb2.active

list=[]
for row1 in sheet1.rows:
	data1=((row1[0].value, row1[4].value))
	#print(data1)
	if data1[0] == None:
		continue
	list.append(data1)
list=list[2:]
#print(list[0])

#for d in list:
#l=list[:3]
#print(l[0])
#for d in l:
for d in list:
	for i in range(9,2200):
		#print(sheet2.cell(row=i,column=2).value)
		if sheet2.cell(row=i,column=2).value == d[0]:
			#print(d[1])
			sheet2.cell(row=i,column=51,value=d[1])
			print(sheet2.cell(row=i,column=51).value)
			break

wb2.save('nanatei-1.xlsx')

