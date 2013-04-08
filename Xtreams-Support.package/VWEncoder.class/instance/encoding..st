"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
encoding: anEncoding

	| newEncoder |
	newEncoder := StreamEncoder new: anEncoding.
	(newEncoder isKindOf: UTF16StreamEncoder) ifTrue: [ newEncoder bigEndian: true ].
	self encoder: newEncoder