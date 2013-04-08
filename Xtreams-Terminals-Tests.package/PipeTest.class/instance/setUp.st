"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
setUp
	| pipe |
	(OSHandle currentOS = #win32) ifTrue: [self error: 'Does not work on Windows' ].
	pipe := OSSystemSupport concreteClass pipeAccessorClass openPair.
	input := pipe first.
	output := pipe last.