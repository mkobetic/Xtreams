"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
write: anInteger from: aStreamable
	"Write anInteger's worth of elements from aStreamable into self."
	"       anInteger       <Integer>       the number of elements to write
		aStreamable     <SequenceableCollection | ReadStream | Buffer>  the source to write in to the destination
		^<Integer>      number of elements written
	""
		String new writing write: 3 from: 'Hello' reading; close; destination
	"
	^aStreamable streamingWrite: anInteger into: self
