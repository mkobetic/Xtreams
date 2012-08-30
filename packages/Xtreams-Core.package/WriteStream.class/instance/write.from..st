accessing
write: anInteger from: aStreamable
	"Write anInteger's worth of elements from aStreamable into self."
	"	anInteger	<Integer>	the number of elements to write
	 	aStreamable	<SequenceableCollection | ReadStream | Buffer>	the source to write in to the destination
		^<Integer>	number of elements written
	""
		String new writing write: 3 from: 'Hello' reading; close; destination
	"
	^aStreamable streamingWrite: anInteger into: self