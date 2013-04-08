"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
on: aDestination bufferSize: bufferSize
	buffer := Buffer new: bufferSize class: aDestination contentsSpecies.
	super on: aDestination