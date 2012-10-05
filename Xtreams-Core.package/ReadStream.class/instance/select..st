enumerating
select: aBlock 
	"Evaluate aBlock with each element, collect into a collection only those elements for which aBlock evaluates to true."
	"	aBlock	<BlockClosure>	#select: style block used to filter the elements
		^		<Collection>		all elements that evaluate to true 
	""
		(1 to: 10) reading select: [ :e | e odd ]
	"
	| contents |
	contents := self contentsSpecies new writing.
	self do: [:each | (aBlock value: each) ifTrue: [contents put: each]].
	^contents close; destination