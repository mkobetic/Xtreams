"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingWriteFrom: aReadStream

	| count |
	count := 0.
	^[ 	[ count := count + (self streamingWrite: DefaultBufferSize from: aReadStream) ] repeat
	] on: Incomplete do: [ :ex | ex count + count ]