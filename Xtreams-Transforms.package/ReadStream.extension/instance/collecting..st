*Xtreams-Transforms-transforming
collecting: aBlock
	"Transform each element using #collect: style block."
	"	aBlock	<BlockClosure>	a #collect: style block used to tranform each element
		^<CollectReadSteam>
	""
		((1 to: 5) reading collecting: [ :e | e * e ]) rest
	""
		((65 to: 90) reading collecting: [ :e | e asCharacter ]) contentsSpecies: String; rest
	"
	^XTCollectReadStream on: self block: aBlock