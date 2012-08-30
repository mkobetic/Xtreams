enumerating
reject: aBlock 
	"Evaluate aBlock with each element, collect into a collection only those elements for which aBlock evaluates to false."
	"	aBlock	<BlockClosure>	#reject: style block used to filter the elements
		^		<Collection>		all elements that evaluate to false 
	""
		(1 to: 10) reading reject: [ :e | e odd ]
	"
	^self select: [:element | (aBlock value: element) == false]