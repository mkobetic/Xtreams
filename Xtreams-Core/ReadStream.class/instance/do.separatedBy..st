"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: enumerating
"
do: elementBlock separatedBy: separatorBlock
	"Evaluate elementBlock for each element in the stream. Between each pair of elements, but not before the first or after the last, evaluate the separatorBlock."
	"       elementBlock    <BlockClosure> evaluated with each element
		separatorBlock  <BlockClosure> evaluated between elements
	"
	| first |
	first := true.
	self do:
		[:elmnt |
		first ifTrue: [first := false]
			ifFalse: [separatorBlock value].
		elementBlock value: elmnt]
