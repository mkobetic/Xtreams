"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: operations
"
literal: literal
	| position |
	position := stream position.
	[stream read: literal size into: cache at: 1] on: Incomplete do: [stream position: position. ^Failure].
	1 to: literal size do: [:i | (cache at: i) == (literal at: i) ifFalse: [stream position: position. ^Failure]].
	^literal