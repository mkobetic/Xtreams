"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
contents
	^collection
		ifNil: [ self originator contentsSpecies withSize: count ]
		ifNotNil: [ collection copyFrom: start to: start + count - 1 ]
