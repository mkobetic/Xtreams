initialize-release
close
	| saved |
	super close.
	saved := cache.
	cache := nil.
	saved == nil ifFalse: [ saved recycle ].