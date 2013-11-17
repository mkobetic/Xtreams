"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: interpreting
"
marshaling: aMarshaler
	"Marshaling streams are used to encode arbitrary smalltalk objects into a sequence of bytes suitable for binary storage or transport. The format of the binary encoding is defined by an ObjectMarshaler and is identified by particular version ID. Custom marshaling schemes can be derived by subclassing ObjectMarshaler. Custom schemes must declare their own (unique) version ID. This method allows to employ a cusomt marshaler instead of the default one (STST2.0).
	A marshaling write stream encodes objects into a binary destination stream.
	""	aMarshaler	<ObjectMarshaler>	implements custom marshaling format
		^			<ObjectWriteSteam>
	""
		| rectangle bytes |
		rectangle := 5 @ 5 extent: 5 @ 5.
		bytes := (ByteArray new writing marshaling: ObjectMarshaler new) put: rectangle; conclusion.
		bytes reading marshaling get
	"
	^ObjectWriteStream on: self marshaler: aMarshaler
