"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex

	| read |
	read := 0.
	[	[ read < anInteger ] whileTrue: [ aSequenceableCollection at: startIndex + read put: self get ]
	] on: Incomplete do: [ :ex | (Incomplete count: read) raise ].
	^read