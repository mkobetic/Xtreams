"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: interpreting
"
marshaling
	"Marshaling streams are used to encode arbitrary smalltalk objects into a sequence of bytes suitable for binary storage or transport. The format of the binary encoding is defined by an ObjectMarshaler and is identified by particular version ID.
	A marshaling write stream encodes objects into a binary destination stream.
	""	^			<ObjectWriteSteam>
	""
		| rectangle bytes |
		rectangle := 5 @ 5 extent: 5 @ 5.
		bytes := ByteArray new writing marshaling put: rectangle; conclusion.
		bytes reading marshaling get
	"
	^ObjectWriteStream on: self
