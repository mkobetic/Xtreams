"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: initialize-release
"
setUp
	marshaler := MessagePackMarshaler new.
	stream := ByteArray new writing.
	marshaling := stream marshaling: marshaler.
	bytes := nil.
	log := nil
