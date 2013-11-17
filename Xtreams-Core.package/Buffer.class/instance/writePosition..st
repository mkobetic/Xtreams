"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing - writing
"
writePosition: aPosition
	^writePosition := (aPosition max: 0) min: dataLength
