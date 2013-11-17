"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
write: aStreamable
	"Write aStreamable into self."
	"       aStreamable     <SequenceableCollection | ReadStream | Buffer>  the source to write in to the destination
		^<Integer>      the number of elements written to the destination"
	"
		String new writing write: 'Hello' reading; close; destination
	"
	^aStreamable streamingWriteInto: self
