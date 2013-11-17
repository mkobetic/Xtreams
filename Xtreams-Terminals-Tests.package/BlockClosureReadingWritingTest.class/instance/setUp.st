"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
setUp

	collection := OrderedCollection new.
	input := [ collection isEmpty ifTrue: [ Incomplete zero raise ]. collection removeFirst ] reading.
	input contentsSpecies: ByteArray.
	output := [ :x | collection addLast: x ] writing.
	output contentsSpecies: ByteArray.
