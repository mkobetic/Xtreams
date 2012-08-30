Reads from a file. The stream is usually created by sending #reading to a Filename. However the actual terminal is an IOAccessor. The original filename is accessible through the IOAccessor. The stream is binary and is naturally positionable.
{{{
	| file |
	file := ObjectMemory imageName asFilename reading.
	[ file read: 13 ] ensure: [ file close ]
}}}
As a convenience, sending #reading to a Filename of a directory will create a stream of all filenames in that directory.
{{{
	'/tmp' asFilename reading rest
}}}

Instance Variables
	position	<Integer> current position of the stream

