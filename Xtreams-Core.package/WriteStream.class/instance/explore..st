"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
explore: aBlock
	" Explore the stream within the block but return to where we started when the block completes. The stream must be positionable."
	"       aBlock  <BlockClosure>  defines the exploration activity
		^               <Object>        result of aBlock"
	"
		String new writing explore: [ :s | s write: 'Hello' ]; write: 'World'; close; destination
	"
	| position |
	position := self position.
	^[aBlock cull: self] ensure: [self position: position]
