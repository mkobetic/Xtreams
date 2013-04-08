"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testWriteDefalteReadInflate

	| data result out in buffer |
	data := ByteArray new: 500.
	1 to: data size do: [ :i | data at: i put: i \\ 5 ].
	buffer := ElasticBuffer on: ByteArray new.
	out := buffer writing compressing.
	in := buffer reading compressing.
	[	out write: data; flush.
		result := in rest.
		self assert: data = result.
	] ensure: [ out close. in close ].