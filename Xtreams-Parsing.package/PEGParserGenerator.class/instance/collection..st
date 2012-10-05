private
collection: aCollection
	| stream |
	stream := String new writing.
	stream write: '(OrderedCollection new'.
	aCollection do: [:each |
		stream write: ' add: '.
		stream write: each.
		stream write: ';'].
	stream write: ' yourself)'.
	^stream contents