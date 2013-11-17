"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing - writing
"
write: anInteger from: aStreamable

	^aStreamable streamingWrite: anInteger into: self
