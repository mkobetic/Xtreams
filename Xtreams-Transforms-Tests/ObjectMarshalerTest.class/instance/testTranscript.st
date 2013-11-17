"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testTranscript
	marshaling put: Transcript.
	marshaling put: (Array with: Transcript).
	self analyse.
	self assert: marshaling get == Transcript.
	self assert: marshaling get = (Array with: Transcript)
