"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
on: aSource first: firstActiveStream
	super on: aSource.
	active := firstActiveStream.
	contentsSpecies := active contentsSpecies
