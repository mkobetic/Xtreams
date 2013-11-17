"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
input

	^input ifNil: [ input := (self output close; terminal) reading ]
