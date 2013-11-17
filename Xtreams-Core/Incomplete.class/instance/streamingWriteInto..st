"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: private
"
streamingWriteInto: aWriteStream
	collection ifNil: [^0].
	aWriteStream write: count from: collection at: start.
	^count
