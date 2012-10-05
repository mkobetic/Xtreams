accessing
insert: anInteger from: aStreamable
	"Insert anIntegers worth of elements from aStreamable into self at current position."
	"	anInteger	<Integer>	the number of elements to insert
	 	aStreamable	<ReadStream | SequenceableCollection | Buffer >	the source to write into the destination
	 	startIndex	<Integer>	the index into aSequenceableCollection to start writing from
		^<Integer>	number of elements inserted
	""
		' World!' copy writing insert: 5 from: 'Hello Underworld!' reading; -= 0; close; destination
	"
	aStreamable streamingInsert: anInteger into: self.
	^anInteger