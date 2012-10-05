*Xtreams-Terminals-converting
writing
	self numArgs = 1 ifTrue: [^XTBlockClosureWriteStream on: self].
	self error: 'Must be a single argument block.'