initialize-release
on: aSource block: aBlock
	self on: aSource.
	block := aBlock.
	contentsSpecies := aSource contentsSpecies.
	direct := true