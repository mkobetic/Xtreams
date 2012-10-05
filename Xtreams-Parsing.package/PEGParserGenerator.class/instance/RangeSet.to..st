lexical
RangeSet: first to: second
	<action: 'RangeSet' arguments: #( 2 4 )>

	second ifNil: [^(Interval from: first asInteger to: first asInteger) printString].
	^(Interval from: first asInteger to: second asInteger) printString