"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: initialize-release
"
on: aSource first: firstActiveStream
	super on: aSource.
	active := firstActiveStream.
	contentsSpecies := active contentsSpecies