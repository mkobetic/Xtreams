"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
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
