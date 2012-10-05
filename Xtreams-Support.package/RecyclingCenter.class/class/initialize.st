class initialization
initialize
	"self initialize"
	| cacheLimit |
	cacheSize := DefaultBufferSize.
	cacheLimit := 3.
	objectspace1 := self new initialize1: cacheLimit.
	fixedspace1 := self new initialize1: cacheLimit.
	objectspaceN := self new initialize: cacheLimit.
	fixedspaceN := self new initialize: cacheLimit