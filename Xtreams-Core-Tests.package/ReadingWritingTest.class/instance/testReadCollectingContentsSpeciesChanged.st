"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - transforming
"
testReadCollectingContentsSpeciesChanged
	| data result |
	data := ByteArray withAll: ((1 to: 16) collect: [:index | 65]).
	self output write: data.
	result :=
		(self input collecting: [:e | Character codePoint: e])
			contentsSpecies: String;
			read: data size.
	self assert: result = (String withAll: (data asArray collect: [:e | Character codePoint: e]))
