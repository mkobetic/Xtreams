"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testWriteEscapedString

	| stream result string |
	string := ' " \ ' withCRs, ' \ '.
	stream := String new writing marshaling: JSON.
	stream put: string.
	result := stream close; terminal.
	self assert: result = '" \" \n  \\ "'