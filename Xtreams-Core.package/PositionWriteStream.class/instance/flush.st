"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
flush
	buffer ifNil: [^self].
	destination write: buffer.
	buffer clear
