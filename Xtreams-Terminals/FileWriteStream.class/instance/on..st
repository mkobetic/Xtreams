"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: initialize-release
"
on: anAccessor
	super on: anAccessor.
	contentsSpecies := ByteArray.
	isPositionable := true.
	position := 0