"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
on: aDestination block: aBlock
	self on: aDestination.
	block := aBlock.
	self contentsSpecies: aDestination contentsSpecies
