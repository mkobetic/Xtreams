"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: interpreting
"
interpreting: type
	"Converts bytes from a binary source according to provided @type. It produces elements of corresponding class, e.g. #float -> Float, #double -> Double, etc. Supported types are defined by the Interpretations shared class variable.
	""	type	<Symbol>	identifies a (primitive) CType, e.g. #float, #long (mapped via Interpretations)
		^		<InterpretedReadStream>
	""
		| doubles bytes |
		doubles := [ Random new next ] reading.
		bytes := (ByteArray new writing interpreting: #double)
			write: 10 from: doubles;
			close;
			terminal.
		(bytes reading interpreting: #double) read: 10
	"
	^self interpreting: type cacheSize: 1
