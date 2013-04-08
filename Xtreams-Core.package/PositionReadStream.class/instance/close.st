"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
close
	buffer isNil ifTrue: [^self].
	super close.
	buffer recycle.
	buffer := nil