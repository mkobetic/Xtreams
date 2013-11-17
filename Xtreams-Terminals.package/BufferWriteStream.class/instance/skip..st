"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
skip: anInteger
	| count |
	count := destination writeSkip: anInteger.
	count ~= anInteger ifTrue: [(Incomplete count: count) raise]
