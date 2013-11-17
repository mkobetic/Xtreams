"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
on: aDestination bufferSize: bufferSize
	buffer := RingBuffer new: bufferSize class: aDestination contentsSpecies.
	super on: aDestination
