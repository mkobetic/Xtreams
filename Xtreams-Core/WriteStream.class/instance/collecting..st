"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: transforming
"
collecting: aBlock
	"Transform each written element using #collect: style block."
	"	aBlock	<BlockClosure>	a #collect: style block used to tranform each element
		^<CollectWriteSteam>
	""
		(Array new writing collecting: [ :e | e * e ]) write: (1 to: 5); conclusion
	""
		(String new writing collecting: [ :e | e asCharacter ]) write: (65 to: 90); conclusion
	"
	^CollectWriteStream on: self block: aBlock
