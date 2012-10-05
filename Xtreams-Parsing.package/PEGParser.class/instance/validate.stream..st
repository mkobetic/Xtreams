parsing
validate: definition stream: aStream
	actor := nil.
	stream := aStream reading.
	self clear.
	^(grammar at: definition) value ~~ Failure