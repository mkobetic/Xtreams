"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
growBy: anInteger
	| replacement |
	replacement := cache copyEmpty: (cache size + anInteger) * 2.
	replacement replaceFrom: 1 to: cache size with: cache startingAt: 1.
	cache := replacement
