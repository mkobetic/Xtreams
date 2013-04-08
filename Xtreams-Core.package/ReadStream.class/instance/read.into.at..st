"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex
	"Read anInteger's worth of elements into aSequenceableCollection starting at startIndex.
	If full anInteger number of elements cannot be read from the source, the Incomplete exception is raised."
	"	anInteger	<Integer>	the number of elements to read
	 	aSequenceableCollection	<SequenceableCollection>	the destination to read into
		startIndex	<Integer>	the index into aSequenceableCollection to start writing to
		^<Integer>	number of elements read
	"
	self subclassResponsibility
	"Subclasses must implement this message. All effort must be taken to read anInteger, blocking if necessary. "