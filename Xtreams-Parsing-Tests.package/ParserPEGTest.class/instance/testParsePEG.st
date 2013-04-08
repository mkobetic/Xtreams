"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testParsePEG
	self assert: (parser parse: 'Grammar' stream: PEG.Parser grammarPEG reading positioning actor: nil) notEmpty.
	self assert: (parser parse: 'Grammar' stream: PEG.Parser grammarPEG reading positioning actor: PEG.ParserParser new) grammar size = 52