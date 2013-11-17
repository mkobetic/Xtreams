"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: compressing
"
trim
	cache := cache copyFrom: readPosition + 1 to: writePosition.
	readPosition := 0.
	dataLength := writePosition := cache size
