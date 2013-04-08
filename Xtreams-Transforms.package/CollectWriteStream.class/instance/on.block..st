"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
on: aDestination block: aBlock
	self on: aDestination.
	block := aBlock.
	self contentsSpecies: aDestination contentsSpecies