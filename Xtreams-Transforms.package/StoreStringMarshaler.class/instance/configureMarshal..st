"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: configuration
"
configureMarshal: writing
	encoding := #utf8.
	(writing encoding: #ascii)
		setLineEndLF;
		write: encoding;
		cr;
		flush.
	^false