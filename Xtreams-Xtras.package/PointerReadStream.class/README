Read stream on external heap, commonly used to unmarshal output or an external library call. The terminal is a CPointer and its associated CType is used to interpret the bytes on the heap. The length of the stream should be set, to avoid reading past the allocated memory space.
{{{
	| buffer |
	buffer := CIntegerType unsignedChar malloc: 50.
	[	buffer writing
			length: 50;
			write: 'Hello World!'.
		buffer reading
			length: 12;
			contentsSpecies: ByteString;
			rest
	] ensure: [ buffer free ]
}}}

Instance Variables
	length	<Integer> allocated size of the stream as a number of elements of associated CType
	contentsSpecies	<Class> species for collections of elements of this stream
	position	<Integer> current position of the stream

