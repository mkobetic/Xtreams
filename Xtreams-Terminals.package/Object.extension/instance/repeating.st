"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: converting
"
repeating
"Provides an infinite stream of itself.
	5 repeating read: 5000
"
	^ConstantReadStream on: self