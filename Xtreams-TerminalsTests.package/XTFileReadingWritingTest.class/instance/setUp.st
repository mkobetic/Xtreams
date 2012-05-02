initialize-release
setUp

	file := FileDirectory default / (self class name , '-' , testSelector).
	output := file writing.
	input := nil