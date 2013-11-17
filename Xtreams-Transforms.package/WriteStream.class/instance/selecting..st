"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: transforming
"
selecting: aBlock
	"Filters written elements using aBlock. aBlock has the same form and semantics as the #select: block on collections."
	"	aBlock	<BlockClosure>	usual #select: style block used to filter the elements passing through
		^<TransformWriteStream>"
	"
		(Array new writing selecting: [ :e | e odd ]) write: (1 to: 10); conclusion
	"
	^self transforming: [:input :output |
		| value |
		[value := input get.
		aBlock cull: value] whileFalse.
		output put: value]
