*Xtreams-Transforms-transforming
transforming: aBlock
	"This is the most general form of transform stream. The block receives two streams, a virtual stream of written elements (input) and the destination (output). The block can read arbitrary number of elements from input (including none) and write arbitrary number of elements into the output (including none). The block will be invoked as many times as necessary to consume any written elements, or until an Incomplete is raised by the destination.
	Note that if the #contentSpecies of the destination doesn't fit the input of the transformation, the #contentsSpecies of the transform stream has to be set explicitly.
	""	aBlock	<BlockClosure>	binary transformation block that reads elements from input (first argument) and writes elements into output (second argument)
		^<TransformWriteStream>
	""	Convert text into a stream of words
		(Array new writing transforming: [ :in :out || word char |
			word := String new writing.
			[	[  (char := in get) = Character space ] whileFalse: [ word put: char ].
			] ensure: [ out put: (word close; destination) ] ]
		)	write: 'hello world! bye world!';
			close;
			terminal
	""	Convert a hex-string into a byte array (2 characters per byte)
		| c2d |
		c2d := [ :char | ('0123456789abcdef' indexOf: char) - 1 ].
		(ByteArray new writing transforming: [ :in :out |
			out put: (c2d value: in get) * 16 + (c2d value: in get) ]
		)	contentsSpecies: String;
			write: '0123456789abcdef';
			close;
			terminal
	"
	^XTTransformWriteStream on: self block: aBlock