"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testParsePEGwithPEG
	parser := parser parse: 'Grammar' stream: PEG.Parser grammarPEG reading positioning actor: PEG.ParserParser new.
	self testParsePEG