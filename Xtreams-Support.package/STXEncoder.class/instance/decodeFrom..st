"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
decodeFrom: aReadStream

	stream := aReadStream.
	^encoder readNextCharacterFrom: self