"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
existing: aClass in: queue

	| collection |
	1 to: queue size do: [:index |
		collection := queue at: index.
		collection == nil ifFalse:
			[queue at: index put: nil.
			^collection]].
	^nil