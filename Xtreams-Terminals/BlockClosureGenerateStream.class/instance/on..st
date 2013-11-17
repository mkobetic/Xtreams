"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
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
