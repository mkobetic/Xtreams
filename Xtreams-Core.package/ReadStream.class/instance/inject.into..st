"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: enumerating
"
inject: initialValue into: binaryBlock
	"Accumulate a running value associated with evaluation of binaryBlock with the each element and the result of evaluation for previous element.
	The initialValue serves as the previous result for evaluation of the first element."
	"       initialValue    <Object>        servers as the previous result for evaluation of the first element.
		binaryBlock     <BlockClosure>  evaluated with each element and result of evaluation of previous element
	""
		(1 to: 10) reading inject: 0 into: [:subTotal :next | subTotal + next].
	"
	| nextValue |
	nextValue := initialValue.
	self do: [:each | nextValue := binaryBlock value: nextValue value: each].
	^nextValue
