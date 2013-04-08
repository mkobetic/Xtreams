"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingInsertInto: aWriteStream
	^length
		ifNil: [ self error: 'Cannot stream from an unbounded stream' ]
		ifNotNil: [ super streamingInsertInto: aWriteStream ]