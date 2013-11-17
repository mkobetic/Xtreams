"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex
	startIndex to: startIndex + anInteger - 1 do: [:index | aSequenceableCollection at: index put: source next].
	^anInteger
