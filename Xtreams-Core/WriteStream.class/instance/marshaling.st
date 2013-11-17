"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
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
