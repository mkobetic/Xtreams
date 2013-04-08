"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
buffer: aBuffer

	buffer ifNotNil: [ buffer recycle ].
	buffer := aBuffer