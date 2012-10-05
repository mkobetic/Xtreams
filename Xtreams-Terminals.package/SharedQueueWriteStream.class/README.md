Write stream on a SharedQueue. Primarily used for data transfer between processes.
{{{
	queue := SharedQueue new.
	in := queue reading.
	out := queue writing.
	received := Array new writing.
	done := Semaphore new.
	consumer :=	
		[ | size |
			[	(size := in get) isZero
			] whileFalse: [ | word |
				word := ByteString new: size.
				in read: size into: word.
				received put: word ].
			done signal.
		] fork.
	#(one two three four) do: [ :word | out put: word size; write: word ].
	out put: 0.
	done wait.
	received conclusion
}}}

Instance Variables
	contentsSpecies	<Class> species for collections of elements of this stream

