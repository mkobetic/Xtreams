"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
writeSize
	"The number of available slots to write in to, which might overwrite elements in dataLength; writeSize >= inactiveSize"

	^(cache size - writePosition + readPosition) min: cache size
