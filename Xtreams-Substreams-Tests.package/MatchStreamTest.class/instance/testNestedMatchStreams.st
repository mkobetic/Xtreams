"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testNestedMatchStreams

	| stream message |
	stream := '123##456##78!!abc##de' reading.
	message := stream ending: '!!'.
	#('123' '456' '78') do: [ :next || part |
		part := message ending: '##'.
		self assert: part rest = next ].
	self assert: message rest isEmpty.