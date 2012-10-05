operations
explore: expression
	| object position |
	position := stream position.
	object := expression value.
	stream position: position.
	^object