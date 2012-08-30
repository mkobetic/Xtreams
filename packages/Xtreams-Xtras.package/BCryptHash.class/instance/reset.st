initialize-release
reset
	
	handle ifNotNil: [library destroyHash: handle. handle := nil].
	key
		ifNil: [self algorithm: nil]
		ifNotNil: [self algorithm: nil key: nil]