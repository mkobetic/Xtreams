"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
initialize
	super initialize.
	useCache := false.
	parser := Parser new.
	references := Dictionary new