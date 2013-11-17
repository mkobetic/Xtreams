"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: transforming
"
doing: aBlock
	"Perform and action with each passing element using #do: style block."
	"	aBlock	<BlockClosure>	a #do: style block invoked with each element as it passes through the stream
		^<CollectReadSteam>
	""
		((1 to: 5) reading doing: [ :e | Transcript space; print: e * e ]) rest
	"
	^self collecting: [:each | (aBlock value: each). each]
