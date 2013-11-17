"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: instance creation
"
on: aReadStream type: aSymbol cacheSize: anInteger
	| interpretation |
	interpretation := InterpretedBytes perform: aSymbol.
	^self on: aReadStream bytesPerElement: (interpretation at: 1) contentsSpecies: (interpretation at: 2) operation: (interpretation at: 3) cacheSize: anInteger
