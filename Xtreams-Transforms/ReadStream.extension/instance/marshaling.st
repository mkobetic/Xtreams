"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: interpreting
"
marshaling
	"Marshaling streams are used to encode arbitrary smalltalk objects into a sequence of bytes suitable for binary storage or transport. The format of the binary encoding is defined by an ObjectMarshaler and is identified by particular version ID. A marshaling read stream decodes objects from a binary source previously encoded by a marshaling write stream.
	""	^	<ObjectReadSteam>
	""
		| rectangle bytes |
		rectangle := 5 @ 5 extent: 5 @ 5.
		bytes := ByteArray new writing marshaling put: rectangle; conclusion.
		bytes reading marshaling get
	"
	^ObjectReadStream on: self
