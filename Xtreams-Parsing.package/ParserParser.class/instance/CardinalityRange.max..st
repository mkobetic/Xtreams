"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: cardinality
"
CardinalityRange: min max: max
	<action: 'CardinalityRange' arguments: #( 1 5 )>
	| optional |
	optional := max - min.
	^(min isZero and: [max = 1])
		ifTrue:	[ [:expression | [parser optional: expression]] ]
		ifFalse:	[ [:expression | [parser repeat: expression min: min optional: optional]] ]