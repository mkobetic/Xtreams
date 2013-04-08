"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
flush
	active == nil ifTrue: [^self].
	active close.
	active := nil