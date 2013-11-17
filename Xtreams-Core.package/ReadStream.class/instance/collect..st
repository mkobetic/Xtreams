"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: enumerating
"
collect: aBlock
	"Evaluate aBlock with each of the values of the receiver as the argument. Collect the resulting values into a collection."
	"       aBlock  <BlockClosure>  #collect: style block transforming the elements being read
		^               <Collection>
	""
		(1 to: 10) reading collect: [ :e | e * e ]
	"
	| contents |
	contents := self contentsSpecies new writing.
	self do: [:each | contents put: (aBlock value: each)].
	^contents close; destination
