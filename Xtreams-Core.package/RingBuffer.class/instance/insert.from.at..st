accessing - writing
insert: anInteger from: aSequenceableCollection at: startIndex

	| tail write temp length position |
	length := dataLength - writePosition.
	write := (dataPosition + writePosition + 1) \\ cache size.
	tail := (cache size - write) min: length.
	temp := self contentsSpecies newRecycled: (length max: DefaultBufferSize).
	temp replaceFrom: 1 to: tail with: cache startingAt: write.
	temp replaceFrom: tail + 1 to: length with: cache startingAt: 1.
	dataLength := dataLength - length.
	self write: anInteger from: aSequenceableCollection at: startIndex.
	position := self writePosition.
	self write: length from: temp.
	self writePosition: position. 
	temp recycle.
	^anInteger