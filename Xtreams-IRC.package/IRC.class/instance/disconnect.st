"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: connect / disconnect
"
disconnect
	output == nil ifTrue: [^self].
	self quit