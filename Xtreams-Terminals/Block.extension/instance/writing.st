"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: converting
"
writing
	self numArgs = 1 ifTrue: [^Xtreams::BlockClosureWriteStream on: self].
	self error: 'Must be a single argument block.'
