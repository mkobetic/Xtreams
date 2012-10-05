accessing
contents
	^collection
		ifNil: [ self originator contentsSpecies withSize: count ]
		ifNotNil: [ collection copyFrom: start to: start + count - 1 ]