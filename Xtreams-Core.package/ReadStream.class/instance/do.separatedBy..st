"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: enumerating
"
do: elementBlock separatedBy: separatorBlock
	"Evaluate elementBlock for each element in the stream. Between each pair of elements, but not before the first or after the last, evaluate the separatorBlock."
	"	elementBlock	<BlockClosure> evaluated with each element
		separatorBlock	<BlockClosure> evaluated between elements
	"
	| first |
	first := true.
	self do:
		[:elmnt |
		first ifTrue: [first := false]
			ifFalse: [separatorBlock value].
		elementBlock value: elmnt]