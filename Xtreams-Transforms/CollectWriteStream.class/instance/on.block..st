"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: initialize-release
"
on: aDestination block: aBlock
	self on: aDestination.
	block := aBlock.
	self contentsSpecies: aDestination contentsSpecies
