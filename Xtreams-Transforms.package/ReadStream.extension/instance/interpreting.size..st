"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: interpreting
"
interpreting: reader size: byteSize
	"Converts bytes from a binary source according to provided @reader block. The block is evaluated with an instance of InterpretedBytes and and index into it from which it should use byteSize bytes to make an object to return.
	""	reader		<BlockClosure>	reading block, e.g. [ :b :i | (b at: i) @ (b at: i + 1) ]
		byteSize	<Integer>	byte size of an element
		^			<InterpretedReadStream>
	""
		| doubles bytes |
		doubles := [ Random new next ] reading.
		bytes := (ByteArray new writing interpreting: #double)
			write: 10 from: doubles;
			close;
			terminal.
		(bytes reading interpreting: [ :b :i | (b floatAt: i) @ (b floatAt: i + 4) ] size: 8) read: 5
	"
	^InterpretedReadStream on: self bytesPerElement: byteSize contentsSpecies: Array operation: reader cacheSize: 1