"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
write: anInteger from: aSequenceableCollection at: startIndex
	"Write anIntegers worth of elements from aSequenceableCollection starting at startIndex into self."
	"       anInteger       <Integer>       the number of elements to write
		aStreamable     <SequenceableCollection>        the source to write in to the destination
		startIndex      <Integer>       the index into aSequenceableCollection to start writing from
		^<Integer>      number of elements written
	""
		String new writing write: 3 from: 'Hello' at: 2; close; destination
	"
	^self subclassResponsibility
