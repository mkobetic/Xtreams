"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
flush
	active == nil ifTrue: [^self].
	active close.
	active := nil
