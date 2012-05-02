*Xtreams-Substreams-substreaming
closing: aBlock
	^(XTPositionReadSubstream on: self)
		closeBlock: aBlock;
		yourself