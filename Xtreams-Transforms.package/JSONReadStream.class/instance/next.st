"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
next
	^next ifNil: [ source get ]
		ifNotNil: [ :c | next := nil. c ]