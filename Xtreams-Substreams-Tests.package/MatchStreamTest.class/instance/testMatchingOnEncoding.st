"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testMatchingOnEncoding

	| stream message crcr |
	stream := (ByteArray new writing encoding: #ascii) setLineEndCRLF; write: '123\\456\\78\\\\abc\\de' withCRs; close; terminal.
	message := stream reading ending: #[13 10 13 10 13 10 13 10].
	message := message encoding: #ascii.
	crcr := String with: Character cr with: Character cr.
	#('123' '456' '78') do: [ :next || part |
		part := message ending: crcr.
		self assert: part rest = next ].
	self assert: message rest isEmpty.