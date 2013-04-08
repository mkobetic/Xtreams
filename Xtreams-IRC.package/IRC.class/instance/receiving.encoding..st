"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private - receiving
"
receiving: aSocketAccessor encoding: anEncoding
	| parser input message |
	parser := PEG.Parser parserPEG parse: 'Grammar' stream: self messageGrammar reading positioning actor: PEG.ParserParser new.
	input := aSocketAccessor reading encoding: anEncoding.

	[message := parser parse: 'message' stream: input positioning actor: self.
	message == nil] whileFalse.

	output := nil