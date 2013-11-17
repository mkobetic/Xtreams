"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: converting
"
writing

    | handle |
    handle := OperatingSystem open: self osNameForAccess attributes: #(O_WRONLY | O_CREAT) mode: nil.
    ^(Xtreams::FileWriteStream on: handle)
	setFilename: self;
	yourself
