"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
setUp

	queue := SharedQueue new.
	(input := queue reading) contentsSpecies: ByteArray.
	(output := queue writing) contentsSpecies: ByteArray