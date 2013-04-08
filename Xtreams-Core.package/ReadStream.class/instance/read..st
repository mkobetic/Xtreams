"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
read: anInteger
	"Read anInteger's worth of elements from self and return them in a collection.
	If full anInteger number of elements cannot be read from the source, the Incomplete exception is raised."
	"	anInteger	<Integer>	the number of elements to read
 	 	^<SequenceableCollection>	a new collection containing anIntegers worth of elements
	"
	| newCollection |
	newCollection := self contentsSpecies withSize: anInteger.
	self read: anInteger into: newCollection at: 1.
	^newCollection