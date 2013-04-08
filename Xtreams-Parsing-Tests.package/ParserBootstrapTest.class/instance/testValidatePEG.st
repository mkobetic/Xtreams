"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testValidatePEG
	self assert: (parser validate: 'Grammar' stream: PEG.Parser grammarPEG reading positioning)