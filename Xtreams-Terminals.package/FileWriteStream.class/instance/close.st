"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
close
	destination isActive ifFalse: [^self].
	destination truncateTo: position.
	destination close