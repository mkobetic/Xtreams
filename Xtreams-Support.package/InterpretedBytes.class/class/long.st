"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: type descriptions
"
long
	
	^(Array with: 4 with: DwordArray with: [:b :i | b unsignedLongAt: i] with: [:b :i :o | b unsignedLongAt: i put: o])