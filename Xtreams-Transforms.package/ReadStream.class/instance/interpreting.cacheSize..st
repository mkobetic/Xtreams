"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: interpreting
"
interpreting: type cacheSize: size
	"Converts bytes from a binary source according to provided @type. It produces elements of corresponding class, e.g. #float -> Float, #double -> Double, etc. Supported types are defined on class side of InterpretedBytes.
	""	type	<Symbol>	identifies a (primitive) CType, e.g. #float, #long (mapped via InterpretatedBytes)
		size		<Integer>	requested cache size (in number of elements)
		^		<InterpretedReadStream>
	""
		| doubles bytes |
		doubles := [ Random new next ] reading.
		bytes := (ByteArray new writing interpreting: #double cacheSize: 10)
			write: 10 from: doubles;
			close;
			terminal.
		(bytes reading interpreting: #double) read: 10
	"
	^InterpretedReadStream on: self type: type cacheSize: size
