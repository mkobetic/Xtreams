"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
setUp

	file := '<1s>-<2s>' expandMacrosWith: self class name with: testSelector.
	file :=
		(OSHandle currentOS = #unix and: [ '/dev/shm' asFilename exists ])
			ifTrue: [ ('/dev/shm/', file) asFilename ]
			ifFalse: [ file asFilename ].
	output := file writing.
	input := file reading.
