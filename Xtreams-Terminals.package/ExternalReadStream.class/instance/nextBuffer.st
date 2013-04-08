"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
nextBuffer

	cachePosition := 0.
	cacheDataSize := (1 max: self bytesForRead) min: cache size.
	self readWait.
	cacheDataSize := source readInto: cache startingAt: 1 for: cacheDataSize