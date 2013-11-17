"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
insert: anInteger from: aSequenceableCollection at: startIndex
	"Insert anIntegers worth of elements from aSequenceableCollection starting at startIndex into self at current position."
	"       anInteger       <Integer>       the number of elements to insert
		aStreamable     <SequenceableCollection>        the source to write into the destination
		startIndex      <Integer>       the index into aSequenceableCollection to start writing from
		^<Integer>      number of elements inserted
	""
		' World!' copy writing insert: 5 from: 'Hello' at: 1; -= 0; close; destination
	"
	self write: anInteger from: aSequenceableCollection at: startIndex.
	^anInteger
