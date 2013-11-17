"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: transforming
"
transforming: aBlock
	"This is the most general form of transform stream. The block receives two streams, the source (input) and a virtual stream of elements to be produced by the stream (output). The block can read arbitrary number of elements from input (including none) and write arbitrary number of elements into the output (including none). The block will be invoked as many times as necessary to produce the required number of elements, or until an Incomplete is raised. Consequently if the block handles Incomplete from the input, it has to raise another Incomplete at some point, otherwise the stream will never end.
	Note that if the contentSpecies of the source doesn't fit the output of the transformation, the contents species of the transform stream has to be set explicitly.
	""	aBlock	<BlockClosure>	binary transformation block that reads elements from input (first argument) and writes elements into output (second argument)
		^<TransformReadStream>
	""	Convert text into a stream of words
		('hello world! bye world!' reading transforming: [ :in :out || word char |
			word := String new writing.
			[	[  (char := in get) = Character space ] whileFalse: [ word put: char ].
			] ensure: [ out put: (word close; destination) ] ]
		)	contentsSpecies: Array;
			rest
	""	Convert a hex-string into a byte array (2 characters per byte)
		| c2d |
		c2d := [ :char | ('0123456789abcdef' indexOf: char) - 1 ].
		('0123456789abcdef' reading transforming: [ :in :out |
			out put: (c2d value: in get) * 16 + (c2d value: in get) ]
		)	buffer: (RingBuffer on: (ByteArray new: 1));
			rest
	"
	^TransformReadStream on: self block: aBlock
