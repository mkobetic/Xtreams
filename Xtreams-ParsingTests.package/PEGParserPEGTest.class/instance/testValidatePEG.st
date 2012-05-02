tests
testValidatePEG
	self assert: (parser validate: 'Grammar' stream: PEGParser grammarPEG reading positioning)