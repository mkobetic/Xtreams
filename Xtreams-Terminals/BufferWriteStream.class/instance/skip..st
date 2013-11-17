"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: seeking
"
skip: anInteger
	| count |
	count := destination writeSkip: anInteger.
	count ~= anInteger ifTrue: [(Incomplete count: count) raise]
