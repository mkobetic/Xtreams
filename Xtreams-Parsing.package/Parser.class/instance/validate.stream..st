"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: parsing
"
validate: definition stream: aStream
	actor := nil.
	stream := aStream reading.
	self clear.
	^(grammar at: definition) value ~~ Failure