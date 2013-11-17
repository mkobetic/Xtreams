"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
contentsFuture
	^cache copyFrom: readPosition + 1 to: readPosition + self readSize
