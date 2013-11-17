"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: interpreting
"
interpreting: reader size: byteSize cacheSize: cacheSize
	"Converts bytes from a binary source according to provided @reader block. The block is evaluated with an instance of InterpretedBytes and and index into it from which it should use byteSize bytes to make an object to return.
	""	reader		<BlockClosure>	reading block, e.g. [ :b :i | (b at: i) @ (b at: i + 1) ]
		byteSize	<Integer>	byte size of an element
		cacheSize	<Integer>	requested cache size (in number of elements)
		^			<InterpretedReadStream>
	""
		| points bytes |
		points := Random new reading transforming: [ :in :out | out put: in get @ in get ].
		bytes := (ByteArray new writing interpreting: [ :b :i :o | (b floatAt: i put: o x) @ (b floatAt: i + 4 put: o y) ] size: 8 )
			write: 10 from: points;
			close;
			terminal.
		(bytes reading interpreting: [ :b :i | (b floatAt: i) @ (b floatAt: i + 4) ] size: 8 cacheSize: 5) read: 5
	"
	^InterpretedReadStream on: self bytesPerElement: byteSize contentsSpecies: Array operation: reader cacheSize: cacheSize
