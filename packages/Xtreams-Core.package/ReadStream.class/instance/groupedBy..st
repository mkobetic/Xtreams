enumerating
groupedBy: aBlock
	"Return a dictionary whose keys are the result of evaluating aBlock for all elements in	 the stream, and the value for each key is a collection of elements that evaluated to that key.
	""	aBlock	<BlockClosure>	#collect: style block evaluated with each element
		^		<Dictionary>		keys are results of aBlock for all elements, values are corresponding elements that evaluated to the key
	""
	     #(1 2 3 4 5) reading groupedBy: [:each | each odd]
	"
	| result |
	result := Dictionary new.
	self do:
		[:each | | key collection |
		key := aBlock value: each.
		collection := result at: key ifAbsentPut: [OrderedCollection new].
		collection add: each].
	self species ~~ OrderedCollection ifTrue:
		["Convert the result collections to be the right type.
		  Note that it should be safe to modify the dictionary
		  while iterating because we only replace values for existing keys"
		result keysAndValuesDo:
			[:key :value | result at: key put: (self contentsSpecies withAll: value)]].

	^result