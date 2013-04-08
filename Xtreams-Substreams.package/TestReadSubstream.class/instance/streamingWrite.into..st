"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingWrite: anInteger into: aWriteStream
	| object count |

	substreamAtEnd ifTrue: [Incomplete zero raise].
	count := 0.
	[[count = anInteger or: [substreamAtEnd]] whileFalse:
		[object := source get.
		((substreamAtEnd := test value: object) not or: [inclusive]) ifTrue:
			[aWriteStream put: object.
			count := count + 1]]]
				on: Incomplete do: [sourceAtEnd := substreamAtEnd := true. (Incomplete count: count) raise].
	count < anInteger ifTrue: [(Incomplete count: count) raise].
	^anInteger