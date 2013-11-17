"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: interpreting
"
marshaling: aMarshaler
	"Marshaling streams are used to encode arbitrary smalltalk objects into a sequence of bytes suitable for binary storage or transport. The format of the binary encoding is defined by an ObjectMarshaler and is identified by particular version ID. Custom marshaling schemes can be derived by subclassing ObjectMarshaler. Custom schemes must declare their own (unique) version ID. This method allows to employ a cusomt marshaler instead of the default one (STST2.0).
	A marshaling read stream decodes objects from a binary source previously encoded by a marshaling write stream.
	""	aMarshaler	<ObjectMarshaler>	implements custom marshaling format
		^			<ObjectReadSteam>
	""
		| rectangle bytes |
		rectangle := 5 @ 5 extent: 5 @ 5.
		bytes := (ByteArray new writing marshaling: ObjectMarshaler new) put: rectangle; conclusion.
		bytes reading marshaling get
	"
	^ObjectReadStream on: self marshaler: aMarshaler
