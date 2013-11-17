"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
on: aSource block: aBlock
	self on: aSource.
	block := aBlock.
	contentsSpecies := aSource contentsSpecies.
	direct := true
