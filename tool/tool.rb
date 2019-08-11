def read_file(f)
	data=[]
	File.open(f,'r') do |file|
		while line = file.gets
			data << line.chop.split(',')
		end
	end
	return data
end


