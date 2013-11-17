"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
on: aDestination
	buffer := Buffer new: DefaultBufferSize class: aDestination contentsSpecies.
	super on: aDestination
