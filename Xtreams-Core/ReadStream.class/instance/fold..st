"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: enumerating
"
fold: binaryBlock
	"Evaluate binaryBlock with the 1st and th 2nd element of the stream, followed by the result of the first evaluation and the 3rd element of the stream, so on until the stream comes to an end."
	"       binaryBlock     <BlockClosure> evaluated with each element
	"

	| current |
	current := self get.
	self do: [:next | current := binaryBlock value: current value: next].
	^current
