"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
on: aSource
	super on: aSource.
	closeBlock := [].
	sourceAtEnd := false.
	substreamClosed := false