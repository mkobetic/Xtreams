Writes to a file. File write streams can be created via the usual #writing message or via #appending which opens the file in appending mode. In appending mode, you cannot position the stream before the end of the file contents, so you can never overwrite existing contents. In writing mode, the file will be truncated at stream's current position when #close is called. To keep the entire contents of the file, use -= 0 to skip to the end before closing. This behavior is different from the classic streams which would erase the contents of the file on opening. The stream is binary and naturally positionable. File write streams that aren't in append mode can also seek past the end of the file, for sparse file writing.
{{{
	| file |
	file := '/dev/shm/xtreams-test' asFilename.
	[	file writing write: 'Hello'; close.
		file appending write: ' World!'; close.
		file contentsOfEntireFile.
	] ensure: [ file delete ]
}}}
It is also possible to send #reading or #writing to a pre-opened IOAcccessor if some other opening mode configuration is desirable. For example to emulate the classic write stream opening behavior, you can use the following:
{{{
	(IOAccessor openFileNamed: '/dev/shm/xtreams-test' 
		direction: IOAccessor writeOnly
		creation: IOAccessor truncateOrCreate
	) writing close
}}}

Instance Variables
	position	<Integer> current position of the stream
	isPositionable	<Boolean> indicates that the file is open in append mode
	contentsSpecies	<Class> species for collections of elements of this stream

