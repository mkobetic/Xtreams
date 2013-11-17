"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: class initialization
"
initialize
	| cacheLimit |
	cacheSize := DefaultBufferSize.
	cacheLimit := 3.
	objectspace1 := self new initialize: cacheLimit.
	fixedspace1 := self new initialize: cacheLimit.
	objectspaceN := self new initialize: cacheLimit.
	fixedspaceN := self new initialize: cacheLimit
