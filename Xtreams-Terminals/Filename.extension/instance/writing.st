"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: converting
"
writing

    | handle |
    handle := OperatingSystem open: self osNameForAccess attributes: #(O_WRONLY | O_CREAT) mode: nil.
    ^(Xtreams::FileWriteStream on: handle)
	setFilename: self;
	yourself
