"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
write: anInteger from: aSequenceableCollection at: startIndex
	startIndex to: anInteger + startIndex - 1 do: [:index |
		marshaler marshal: self object: (aSequenceableCollection at: index).
		self complete].
	^anInteger