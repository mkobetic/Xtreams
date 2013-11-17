"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
contents
	^collection
		ifNil: [ self originator contentsSpecies withSize: count ]
		ifNotNil: [ collection copyFrom: start to: start + count - 1 ]
