accessing
insert: aStreamable
	"Insert aStreamable into self at current position."
	"	aStreamable	<SequenceableCollection | ReadStream | Buffer>	the source to write in to the destination
	 	^<Integer>	the number of elements written to the destination"
	"
		' World!' copy writing insert: 'Hello' reading; -= 0; close; destination
	"
	^aStreamable streamingInsertInto: self