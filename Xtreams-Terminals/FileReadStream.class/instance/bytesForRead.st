"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: private
"
bytesForRead

	"Ideally we'd ask for the fileSize and subtract that from our position, but calling #fileSize is a slow primitive"
	^cache size
