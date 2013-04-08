"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
write: anInteger from: aSequenceableCollection at: startIndex

	| offset |
	offset := 0.
	[ offset < anInteger ] whileTrue: [
		self put: (aSequenceableCollection at: startIndex + offset) ].
	^anInteger