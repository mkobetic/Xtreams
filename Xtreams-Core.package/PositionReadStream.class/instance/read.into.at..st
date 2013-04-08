"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex

	^[	buffer read: anInteger into: aSequenceableCollection at: startIndex. anInteger
	] on: Incomplete do: [:exception || bufferCount sourceCount |
		bufferCount := exception count.
		sourceCount := anInteger - bufferCount.
		[source read: sourceCount into: aSequenceableCollection at: startIndex + exception count]
			on: Incomplete do: [:incomplete | sourceCount := incomplete count].
		buffer write: sourceCount from: aSequenceableCollection at: startIndex + bufferCount.
		buffer readSkip: sourceCount.
		(sourceCount + bufferCount) < anInteger ifTrue: [
			(Incomplete on: aSequenceableCollection count: sourceCount + bufferCount at: startIndex) raise].
		anInteger ]