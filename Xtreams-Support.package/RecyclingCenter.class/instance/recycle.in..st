"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
recycle: aCollection in: queue

	1 to: queue size do: [:index |
		(queue at: index) == nil ifTrue: [
			queue at: index put: aCollection.
			^self] ].