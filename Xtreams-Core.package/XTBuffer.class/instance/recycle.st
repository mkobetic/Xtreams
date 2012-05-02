initialize-release
recycle

	| saved |
	saved := cache.
	cache := nil.
	saved == nil ifFalse: [ saved recycle ]