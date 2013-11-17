"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
insert: anInteger from: aSequenceableCollection at: startIndex
	destination := destination copyGrownToAtLeast: destination size + anInteger.
	destination replaceFrom: position + anInteger + 1 to: length + anInteger with: destination startingAt: position + 1.
	destination replaceFrom: position + 1 to: position + anInteger with: aSequenceableCollection startingAt: startIndex.
	position := position + anInteger.
	length := length + anInteger.
	^anInteger