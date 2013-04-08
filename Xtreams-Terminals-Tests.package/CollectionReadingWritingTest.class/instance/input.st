"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
input

	^input ifNil: [ input := (self output close; terminal) reading ]