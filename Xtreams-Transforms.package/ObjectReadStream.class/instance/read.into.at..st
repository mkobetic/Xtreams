"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex
	| count |
	count := 0.
	[anInteger timesRepeat:
		[aSequenceableCollection at: startIndex + count put: (marshaler unmarshal: self).
		self complete.
		count := count + 1]]
			on: Incomplete do: [:exception |
				self complete.
				(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger