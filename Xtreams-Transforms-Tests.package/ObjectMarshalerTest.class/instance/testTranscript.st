"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testTranscript
	marshaling put: Transcript.
	marshaling put: (Array with: Transcript).
	self analyse.
	self assert: marshaling get == Transcript.
	self assert: marshaling get = (Array with: Transcript)