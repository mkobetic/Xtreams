"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingWriteInto: aWriteStream
	aWriteStream write: self size from: self at: 1.
	^self size
