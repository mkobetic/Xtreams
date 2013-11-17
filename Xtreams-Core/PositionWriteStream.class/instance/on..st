"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: initialize-release
"
on: aDestination
	buffer := Buffer new: DefaultBufferSize class: aDestination contentsSpecies.
	super on: aDestination
