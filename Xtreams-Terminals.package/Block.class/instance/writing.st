"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: converting
"
writing
	self numArgs = 1 ifTrue: [^Xtreams::BlockClosureWriteStream on: self].
	self error: 'Must be a single argument block.'
