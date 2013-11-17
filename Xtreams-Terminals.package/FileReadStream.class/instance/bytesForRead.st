"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
bytesForRead

	"Ideally we'd ask for the fileSize and subtract that from our position, but calling #fileSize is a slow primitive"
	^cache size
