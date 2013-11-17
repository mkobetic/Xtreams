"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: instance creation
"
on: aReadStream type: aSymbol cacheSize: anInteger
	| interpretation |
	interpretation := InterpretedBytes perform: aSymbol.
	^self on: aReadStream bytesPerElement: (interpretation at: 1) contentsSpecies: (interpretation at: 2) operation: (interpretation at: 3) cacheSize: anInteger
