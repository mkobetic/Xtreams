accessing
read: anInteger into: aSequenceableCollection
	"Read anInteger's worth of elements into aSequenceableCollection starting from index 1.
	If full anInteger number of elements cannot be read from the source, the Incomplete exception is raised."
	"	anInteger	<Integer>	the number of elements to read
	 	aSequenceableCollection	<SequenceableCollection>	the destination to read into
		^<Integer>	number of elements read
	"
	^self read: anInteger into: aSequenceableCollection at: 1