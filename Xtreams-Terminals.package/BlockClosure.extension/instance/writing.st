"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: converting
"
writing
	self numArgs = 1 ifTrue: [^BlockClosureWriteStream on: self].
	self error: 'Must be a single argument block.'