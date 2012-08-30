*Xtreams-Substreams-substreaming
closing: aBlock
	^(XTPositionWriteSubstream on: self)
		closeBlock: aBlock;
		yourself