"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
parser

	^parser ifNil: [ parser := Parser parserPEG parse: 'Grammar' stream: self grammar actor: ParserParser new ]