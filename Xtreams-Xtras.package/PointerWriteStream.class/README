Write stream on external heap, commonly used to marshal input for an external library call. The terminal is a CPointer and its associated CType is used to interpret the bytes on the heap. The length of the stream must be set, to avoid writing past the allocated memory space. If more objects are written than can fit in the pre-allocated space, a new larger heap chunk is automatically allocated to accommodate it (the contents of the old chunk are copied over and the chunk is deallocated). Similarly closing the write stream will reallocate and shrink the write stream to its position at that time.
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
	position	<Integer> current position of the stream
	contentsSpecies	<Class> species for collections of elements of this stream

