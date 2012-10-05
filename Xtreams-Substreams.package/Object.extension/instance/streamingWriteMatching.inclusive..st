*Xtreams-Substreams-private
streamingWriteMatching: aStream inclusive: tail
	^[:each | each == self] streamingWriteMatching: aStream inclusive: tail