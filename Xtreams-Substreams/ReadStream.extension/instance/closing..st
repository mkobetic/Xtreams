"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: substreaming
"
closing: aBlock
	^(PositionReadSubstream on: self)
		closeBlock: aBlock;
		yourself
