"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testReadPastEndOfCompressedData

	| data compressed decompressing overconsumed decompressed |
	data := ByteArray new: 50 withAll: 42.
	compressed := ByteArray new writing compressing write: data; close; terminal.
	compressed := compressed, (ByteArray new: 20 withAll: 0).
	decompressing := compressed reading compressing.
	[	overconsumed := false.
		decompressed := decompressing rest.
		self assert: decompressed = data
	] ensure: [ decompressing close ].