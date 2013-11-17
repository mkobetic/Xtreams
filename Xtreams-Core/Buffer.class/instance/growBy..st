"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: private
"
growBy: anInteger
	| replacement |
	replacement := cache copyEmpty: (cache size + anInteger) * 2.
	replacement replaceFrom: 1 to: cache size with: cache startingAt: 1.
	cache := replacement
