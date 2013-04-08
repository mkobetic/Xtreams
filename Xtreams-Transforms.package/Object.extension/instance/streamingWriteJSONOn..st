"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingWriteJSONOn: stream
"Write the receiver in JSON format to the stream. Usually that means emitting a JSON object. The default behavior is to follow the class shape. If this is being customized for a specific class, it is imperative that the pattern below is followed, where the putObjectWith: message is sent to the stream to handle all the object formatting and the block argument action is used to emit each key/value pair.
"
	^stream putObjectWith: [ :emitKeyValue |
		self class instVarNames keysAndValuesDo: [ :index :name |
			emitKeyValue value: name value: (self instVarAt: index) ] ]