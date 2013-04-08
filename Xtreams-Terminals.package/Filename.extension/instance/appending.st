"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: converting
"
appending
	^(IOAccessor openFileNamed: self direction: IOAccessor appendOnly creation: IOAccessor mayCreate) writing
		position: self fileSize;
		isPositionable: false;
		yourself