"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: line-end
"
setLineEndAuto

	IOAccessor defaultClass = PCIOAccessor
		ifTrue:	[self setLineEndCRLF]
		ifFalse:	[self setLineEndLF]