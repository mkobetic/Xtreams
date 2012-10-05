initialize-release
release
	
	handle ifNotNil: [library destroyHash: handle. handle := nil].
	object ifNotNil: [object free. object := nil].
	provider ifNotNil: [
		library closeAlgorithmProvider: provider.
		provider free.
		provider := nil].
	library release