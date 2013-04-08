"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: utilities
"
generateHtmlDocsInto: directory
	"Convert package comments into a set of web pages and put the files into @directory.
	""
		self generateHtmlDocsInto: Kernel.ObjectMemory imageDirectory
	"
	((Store.Registry bundleNamed: 'XtreamsDevelopment') leafItems
		reject: [ :p | '*-Tests' match: p name ]
	) collect: [ :p || body file |
		body := self process: p comment reading.
		file := directory / (p name, '.html').
		file exists ifTrue: [ file delete ].
		(file writing encoding: #ascii)
			write: '<html>'; cr;
			write: '<head>'; cr;
			write: '<title>'; write: p name; write: '</title>'; cr;
			write: self docsCSS; cr;
			write: '</head>'; cr;
			write: '<body>'; cr;
			write: body printString; cr;
			write: '</body>'; cr;
			write: '</html>';
			close ]