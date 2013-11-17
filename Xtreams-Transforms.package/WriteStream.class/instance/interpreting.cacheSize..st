"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: interpreting
"
interpreting: type cacheSize: size
	"Converts consumed elements into bytes of pre-configured (primitive) CType, e.g. float, long etc. The type of the written elements must match the CType and the underlying destination must be binary.
	""	type	<Symbol>	identifies a (primitive) CType, e.g. #float, #long (mapped via Interpretations)
		size		<Integer>	requested buffer size (in number of elements)
		^		<InterpretedWriteStream>
	""
		| doubles bytes |
		doubles := [ Random new next ] reading.
		bytes := (ByteArray new writing interpreting: #double size: 10)
			write: 10 from: doubles;
			close;
			terminal.
		(bytes reading interpreting: #double) read: 10
	"
	^InterpretedWriteStream on: self type: type cacheSize: size
