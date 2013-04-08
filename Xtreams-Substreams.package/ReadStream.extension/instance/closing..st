"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: substreaming
"
closing: aBlock
	^(PositionReadSubstream on: self)
		closeBlock: aBlock;
		yourself