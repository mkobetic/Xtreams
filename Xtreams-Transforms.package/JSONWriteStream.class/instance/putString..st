"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: actions
"
putString: aString
	<action: #{Core.String}>
	<action: #{Core.ByteString}>
	<action: #{Core.TwoByteString}>
	<action: #{Core.Symbol}>
	<action: #{Core.ByteSymbol}>
	<action: #{Core.TwoByteSymbol}>

	| from size to |
	destination write: '"'.
	size := aString size.
	from := 1.
	to := 0.
	[ (to := to + 1) > size ] whileFalse: [ | c |
		c := aString at: to.
		(self isEscaped: c) ifTrue: [
			destination write: to - from from: aString at: from.
			self putEscapedCharacter: c.
			from := to + 1 ] ].
	from > size ifFalse: [ destination write: size - from + 1 from: aString at: from ].
	destination write: '"'