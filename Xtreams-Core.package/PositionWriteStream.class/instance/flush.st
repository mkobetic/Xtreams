"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
flush
	buffer ifNil: [^self].
	destination write: buffer; flush.
	buffer clear