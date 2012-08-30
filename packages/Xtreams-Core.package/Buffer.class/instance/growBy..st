private
growBy: anInteger
	| replacement |
	replacement := cache copyEmpty: (cache size + anInteger) * 2.
	replacement replaceFrom: 1 to: cache size with: cache startingAt: 1.
	cache := replacement