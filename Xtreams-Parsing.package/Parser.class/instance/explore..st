"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: operations
"
explore: expression
	| object position |
	position := stream position.
	object := expression value.
	stream position: position.
	^object