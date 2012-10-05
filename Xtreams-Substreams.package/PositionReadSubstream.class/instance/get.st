accessing
get
	| object |
	object := super get.
	position := position + 1.
	^object