initialize-release
on: aDestination bufferSize: bufferSize
	buffer := XTRingBuffer new: bufferSize class: aDestination contentsSpecies.
	super on: aDestination