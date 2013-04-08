"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
writeSize
	"The number of available slots to write in to, which might overwrite elements in dataLength; writeSize >= inactiveSize"

	^(cache size - writePosition + readPosition) min: cache size