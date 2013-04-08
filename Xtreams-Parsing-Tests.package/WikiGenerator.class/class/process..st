"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: utilities
"
process: input
	"Convert input into an xhtml XML document.
	""	input	<ReadStream>	text with wiki markup
		^		<XML.Element>
	""
		self process: 'Single paragraph with *bold* and _italic_ text and a [link]' reading
	""
		| package div file |
		package := Store.Registry packageNamed: 'Xtreams-Core'.
		div := self process: package comment reading.
		file := '/dev/shm/', package name, '.html'.
		file asFilename writing write: '<html><body>'; write: div printString; write: '</body></html>'; close.
		ExternalWebBrowser open: 'file://', file
	"
	^self parser parse: 'Page' stream: input actor: self new