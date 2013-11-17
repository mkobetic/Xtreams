"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: private
"
streamingInsertInto: aWriteStream
	collection ifNil: [^0].
	aWriteStream insert: count from: collection at: start.
	^count
