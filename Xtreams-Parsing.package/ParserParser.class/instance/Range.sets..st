"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: terminals
"
Range: excluding sets: sets
	<action: 'Range' arguments: #( 3 4 )>

	sets isEmpty ifTrue: [
		^excluding
			ifNil:	[self DOT]
			ifNotNil:	[ [parser not: [parser anything]] ]].
	^excluding
		ifNil:	[ [parser including: sets] ]
		ifNotNil:	[ [parser excluding: sets] ]