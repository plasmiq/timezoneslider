Timezoneslider::Geonames = open("db/cities.txt").readlines.map do |l|
	arr = Array.new(2)
	elems = l.split("\t")
	arr[0] = elems[0]
	arr[1] = elems[1].delete("\n")
	arr 	
end
