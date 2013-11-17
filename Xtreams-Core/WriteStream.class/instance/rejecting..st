"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: transforming
"
rejecting: aBlock
	"Filters written elements using aBlock. aBlock has the same form and semantics as the #reject: block on collections."
	"	aBlock	<BlockClosure>	usual #reject: style block used to filter the elements passing through
		^<TransformWriteStream>"
	"
		(Array new writing rejecting: [ :e | e odd ]) write: (1 to: 10); conclusion
	"
	^self selecting: [:each | (aBlock cull: each) not]
