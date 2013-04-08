"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: converting
"
reading
	self isDirectory ifFalse: [^(IOAccessor openFileNamed: self direction: IOAccessor readOnly creation: IOAccessor noCreate) reading].

	"Return the directory contents as a stream of filenames"
	^([self directoryContents]
		on:	self errorReporter errorSignal
		do:	[:ex | ex return: #()])
			reading collecting: [:each | self construct: each asFilename]