initialize-release
initialize
	super initialize.
	useCache := false.
	parser := PEGParser new.
	references := Dictionary new