"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: initialize-release
"
setUp

	collection := OrderedCollection new.
	input := [ collection isEmpty ifTrue: [ Incomplete zero raise ]. collection removeFirst ] reading.
	input contentsSpecies: ByteArray.
	output := [ :x | collection addLast: x ] writing.
	output contentsSpecies: ByteArray.
