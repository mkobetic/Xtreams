"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
parser

	^Parser parserPEG
		parse: 'Grammar'
		stream: Parser grammarWiki reading
		actor: ParserParser new