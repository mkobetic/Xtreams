"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: transforming
"
collecting: aBlock
	"Transform each element using #collect: style block."
	"	aBlock	<BlockClosure>	a #collect: style block used to tranform each element
		^<CollectReadSteam>
	""
		((1 to: 5) reading collecting: [ :e | e * e ]) rest
	""
		((65 to: 90) reading collecting: [ :e | e asCharacter ]) contentsSpecies: String; rest
	"
	^CollectReadStream on: self block: aBlock
