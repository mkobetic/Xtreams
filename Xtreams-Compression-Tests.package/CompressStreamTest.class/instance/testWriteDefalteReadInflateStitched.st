"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testWriteDefalteReadInflateStitched

	| data result out in buffer |
	data := ByteArray new: 500.
	1 to: data size do: [ :i | data at: i put: i \\ 5 ].
	buffer := ElasticBuffer on: ByteArray new.
	out := [ buffer writing limiting: 10 ] reading stitching compressing.
	[	out write: data; flush.
	] ensure: [ out close ].
	in := [ buffer readSize > 0 ifFalse: [ Incomplete zero raise]. buffer reading limiting: 10 ] reading stitching compressing.
	[	result := in rest.
	] ensure: [ in close ].
	self assert: data = result.