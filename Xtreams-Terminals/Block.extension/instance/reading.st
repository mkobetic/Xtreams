"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: converting
"
reading
	self numArgs = 0 ifTrue: [^Xtreams::BlockClosureReadStream on: self].
	self numArgs = 1 ifTrue: [^Xtreams::BlockClosureGenerateStream on: self].
	self error: 'More arguments than we can poke a stick at!'
