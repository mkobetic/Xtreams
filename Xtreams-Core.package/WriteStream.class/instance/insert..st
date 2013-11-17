"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
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
