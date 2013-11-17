"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: converting
"
reading
	self numArgs = 0 ifTrue: [^Xtreams::BlockClosureReadStream on: self].
	self numArgs = 1 ifTrue: [^Xtreams::BlockClosureGenerateStream on: self].
	self error: 'More arguments than we can poke a stick at!'
