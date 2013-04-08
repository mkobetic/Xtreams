"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
close
	| saved |
	super close.
	saved := cache.
	cache := nil.
	saved == nil ifFalse: [ saved recycle ].