"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
growBy: anInteger
	| split replacement growth |
	split := dataPosition + writePosition.
	cache size isZero ifFalse: [split := split \\ cache size].
	split isZero ifTrue: [split := cache size].
	growth := cache size + anInteger + anInteger.
	replacement := cache copyEmpty: cache size + growth.
	replacement replaceFrom: 1 to: split with: cache startingAt: 1.
	replacement replaceFrom: split + growth + 1 to: replacement size with: cache startingAt: split + 1.
	cache := replacement.
	split <= dataPosition ifTrue: [dataPosition := dataPosition + growth]
