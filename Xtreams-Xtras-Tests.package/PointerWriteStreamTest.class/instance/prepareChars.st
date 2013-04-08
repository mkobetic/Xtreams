"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
prepareChars

	| pointer |
	pointer := CIntegerType char malloc: 50.
	stream := pointer writing length: 50; yourself.