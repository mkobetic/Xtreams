"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
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
