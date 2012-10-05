seeking
explore: aBlock
	" Explore the stream within the block but return to where we started when the block completes. The stream must be positionable."
	"	aBlock	<BlockClosure>	defines the exploration activity
		^		<Object>	result of aBlock"
	"
		'Hello' reading explore: [ :s | s -= 0 ]; rest
	"
	| position |
	position := self position.
	^[aBlock cull: self] ensure: [self position: position]