"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex
	| count |
	count := 0.
	[anInteger timesRepeat:
		[marshaler analyse: self.
		aSequenceableCollection at: startIndex + count put: log conclusion.
		log := String new writing.
		self complete.
		count := count + 1]]
			on: Incomplete do: [:exception |
				aSequenceableCollection at: startIndex + count put: log conclusion.
				log := String new writing.
				self complete.
				(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
