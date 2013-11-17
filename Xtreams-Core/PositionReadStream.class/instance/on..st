"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: initialize-release
"
on: aSource
	buffer := Buffer new: DefaultBufferSize class: aSource contentsSpecies.
	super on: aSource
