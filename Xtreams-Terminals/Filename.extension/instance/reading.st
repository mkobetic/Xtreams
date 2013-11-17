"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
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
