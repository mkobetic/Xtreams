"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingWriteInto: aWriteStream
	^length
		ifNil: [ self error: 'Cannot stream from an unbounded stream' ]
		ifNotNil: [ super streamingWriteInto: aWriteStream ]