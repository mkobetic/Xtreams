"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: instance creation
"
on: aWriteStream type: aType cacheSize: aSize
	| interpretation |
	interpretation := InterpretedBytes perform: aType.
	^self on: aWriteStream bytesPerElement: (interpretation at: 1) contentsSpecies: (interpretation at: 2) operation: (interpretation at: 4) cacheSize: aSize
