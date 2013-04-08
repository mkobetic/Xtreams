"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
setUp

	pointer := CIntegerType unsignedChar malloc: 1.
	(input := pointer reading) contentsSpecies: ByteArray.
	(output := pointer writing) contentsSpecies: ByteArray