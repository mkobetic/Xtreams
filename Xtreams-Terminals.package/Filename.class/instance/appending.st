"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: converting
"
appending

    | handle |
    handle := OperatingSystem open: self osNameForAccess attributes: #(O_APPEND O_CREAT) mode: nil.
    ^(Xtreams::FileWriteStream on: handle)
	setFilename: self;
	position: self fileSize;
	isPositionable: false;
	yourself
