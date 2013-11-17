"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: interpreting
"
interpreting: writer size: byteSize cacheSize: cacheSize
	"Converts objects into bytes in a binary destination according to provided @writer block. The block is evaluated with an instance of InterpretedBytes an index and object to write into the bytes.
	""	type		<Symbol>	identifies a (primitive) CType, e.g. #float, #long (mapped via Interpretations)
		byteSize	<Integer>	byte size of an element
		cacheSize	<Integer>	requested cache size (in number of elements)
		^			<InterpretedWriteStream>
	""
		| points bytes |
		points := Random new reading transforming: [ :in :out | out put: in get @ in get ].
		bytes := (ByteArray new writing interpreting: [ :b :i :o | (b floatAt: i put: o x) @ (b floatAt: i + 4 put: o y) ] size: 8 )
			write: 10 from: points;
			close;
			terminal.
		(bytes reading interpreting: [ :b :i | (b floatAt: i) @ (b floatAt: i + 4) ] size: 8 cacheSize: 5) read: 5
	"
	^InterpretedWriteStream on: self bytesPerElement: byteSize contentsSpecies: Array operation: writer cacheSize: cacheSize
