"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
on: aSource block: aBlock
	self on: aSource.
	block := aBlock.
	contentsSpecies := aSource contentsSpecies.
	direct := true