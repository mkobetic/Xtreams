"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: converting
"
reading

	self isDirectory ifFalse: [ | handle |
	    handle := OperatingSystem open: self osNameForAccess attributes: #(O_RDONLY) mode: nil.
	    ^(Xtreams::FileReadStream on: handle)
		setFilename: self;
		yourself ].

	"Return the directory contents as a stream of filenames"
	^([self directoryContents]
		on:     Error
		do:     [:ex | ex return: #()])
			reading collecting: [:each | self construct: each asFilename]
