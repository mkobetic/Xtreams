"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
on: aDestination first: firstActiveStream
	super on: aDestination.
	active := firstActiveStream.
	contentsSpecies := active contentsSpecies