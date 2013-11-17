"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
on: aSource
	buffer := Buffer new: DefaultBufferSize class: aSource contentsSpecies.
	super on: aSource
