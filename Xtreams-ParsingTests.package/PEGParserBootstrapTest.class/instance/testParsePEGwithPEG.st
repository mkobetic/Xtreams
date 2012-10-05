testing
testParsePEGwithPEG
	parser := parser parse: 'Grammar' stream: PEGParser grammarPEG reading positioning actor: PEGParserParser new.
	self testParsePEG