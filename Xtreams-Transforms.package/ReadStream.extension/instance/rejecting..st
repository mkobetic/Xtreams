*Xtreams-Transforms-transforming
rejecting: aBlock
	"Filters elements from the source using aBlock. aBlock has the same form and semantics as the #reject: block on collections."
	"	aBlock	<BlockClosure>	usual #reject: style block used to filter the elements passing through
		^<TransformReadStream>"
	"
		((1 to: 10) reading rejecting: [ :e | e odd ]) rest
	"
	^self transforming: [:input :output |
		| value |
		[value := input get.
		aBlock cull: value] whileTrue.
		output put: value]