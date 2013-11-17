"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
insert: aStreamable
	"Insert aStreamable into self at current position."
	"       aStreamable     <SequenceableCollection | ReadStream | Buffer>  the source to write in to the destination
		^<Integer>      the number of elements written to the destination"
	"
		' World!' copy writing insert: 'Hello' reading; -= 0; close; destination
	"
	^aStreamable streamingInsertInto: self
