testing
testParsePEG
	self assert: (parser parse: 'Grammar' stream: PEGParser grammarPEG reading positioning actor: nil) notEmpty.
	self assert: (parser parse: 'Grammar' stream: PEGParser grammarPEG reading positioning actor: PEGParserParser new) grammar size = 52