"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
on: aBlockClosure
	super on: aBlockClosure.
	contentsSpecies := Array.
	readingSemaphore := Semaphore new.
	writingSemaphore := Semaphore new.
	closed := false.
	process :=
		[aBlockClosure value: [:in |
			writingSemaphore wait.
			current := in.
			readingSemaphore signal] writing.
		closed := true] fork
