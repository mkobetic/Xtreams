"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: lexical
"
RangeSet: first to: second
	<action: 'RangeSet' arguments: #( 2 4 )>

	second ifNil: [^Interval from: first asInteger to: first asInteger].
	^Interval from: first asInteger to: second asInteger