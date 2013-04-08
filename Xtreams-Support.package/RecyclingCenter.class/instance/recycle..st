"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: recycling
"
recycle: aCollection
	| queue |
	queue := recycled at: aCollection class ifAbsent: [^self].
	mutex critical: [ self recycle: aCollection in: queue ]