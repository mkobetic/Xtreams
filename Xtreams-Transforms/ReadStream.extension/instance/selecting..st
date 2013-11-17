"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: transforming
"
selecting: aBlock
	"Filters elements from the source using aBlock. aBlock has the same form and semantics as the #select: block on collections."
	"	aBlock	<BlockClosure>	usual #select: style block used to filter the elements passing through
		^<TransformReadStream>"
	"
		((1 to: 10) reading selecting: [ :e | e odd ]) rest
	"
	^self transforming: [:input :output |
		| value |
		[value := input get.
		aBlock cull: value] whileFalse.
		output put: value]
