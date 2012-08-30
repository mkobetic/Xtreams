initialize-release
setUp

	queue := SharedQueue new.
	(input := queue reading) contentsSpecies: ByteArray.
	(output := queue writing) contentsSpecies: ByteArray