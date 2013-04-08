"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: recycling
"
existing: aClass
	| queue |
	queue := recycled at: aClass ifAbsent: [^nil].
	^mutex critical: [ self existing: aClass in: queue ]