"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingInsertInto: aWriteStream
	aWriteStream insert: self size from: self at: 1.
	^self size
