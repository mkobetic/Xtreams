"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
write: anInteger from: aSequenceableCollection at: startIndex
	startIndex to: startIndex + anInteger - 1 do: [:index | destination nextPut: (aSequenceableCollection at: index)].
	^anInteger