"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
write: anInteger from: aSequenceableCollection at: startIndex
	startIndex to: startIndex + anInteger - 1 do: [:index |
		destination add: (aSequenceableCollection at: index)].
	^anInteger