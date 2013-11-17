"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: xtreams
"
streamingReadMatching: aStream inclusive: tail
	^[:each | each == self] streamingReadMatching: aStream inclusive: tail
