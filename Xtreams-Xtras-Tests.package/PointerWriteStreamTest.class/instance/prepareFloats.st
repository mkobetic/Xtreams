"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
prepareFloats

	| pointer |
	pointer := CLimitedPrecisionRealType float malloc: 50.
	stream := pointer writing length: 50; yourself.