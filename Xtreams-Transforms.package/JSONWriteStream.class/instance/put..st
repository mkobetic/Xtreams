"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
put: anObject

	(ActionMap at: anObject class ifAbsent: [nil])
		ifNil: [ anObject streamingWriteJSONOn: self ]
		ifNotNil: [ :selector | self perform: selector with: anObject ]