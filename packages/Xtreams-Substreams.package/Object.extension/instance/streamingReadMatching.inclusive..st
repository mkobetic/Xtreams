*Xtreams-Substreams-private
streamingReadMatching: aStream inclusive: tail
	^[:each | each == self] streamingReadMatching: aStream inclusive: tail