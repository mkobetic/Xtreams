"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
atEnd

	^(cachePosition < cacheDataSize or: [
		self nextBuffer.
		cacheDataSize > 0 ]
	) not