*Xtreams-Terminals-converting
reading
	self numArgs = 0 ifTrue: [^XTBlockClosureReadStream on: self].
	self numArgs = 1 ifTrue: [^XTBlockClosureGenerateStream on: self].
	self error: 'More arguments than we can poke a stick at!'