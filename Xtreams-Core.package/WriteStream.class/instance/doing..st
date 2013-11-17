"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: transforming
"
doing: aBlock
	"Perform and action with each passing element using #do: style block."
	"	aBlock	<BlockClosure>	a #do: style block invoked with each element as it passes through the stream
		^<CollectWriteSteam>
	""
		(Array new writing doing: [ :e | Transcript space; print: e * e ]) write: (1 to: 10); conclusion
	"
	^self collecting: [:each | (aBlock value: each). each]
