"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: initialize-release
"
on: aSource block: aBlock
	self on: aSource.
	block := aBlock.
	contentsSpecies := aSource contentsSpecies.
	direct := true
