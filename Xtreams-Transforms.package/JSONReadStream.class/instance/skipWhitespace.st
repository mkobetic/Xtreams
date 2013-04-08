"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
skipWhitespace

	| c |
	[ Whitespace includes: (c := self next) ] whileTrue.
	next := c