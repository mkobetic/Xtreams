"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingWriteJSONOn: stream

	stream putObjectWith: [ :emitKeyValue |
		emitKeyValue
			value: #example1 value: 'Produced from JSONMarshalingTest';
			value: #example2 value: Dictionary new ]