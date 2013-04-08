"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: utilities
"
generateWikiDocsInto: directory
	"Save package comments into a set of wiki pages for the project site wiki. Put the files into @directory.
	""
		self generateWikiDocsInto: Kernel.ObjectMemory imageDirectory
	""
		self generateWikiDocsInto: (OS.Filename fromComponents: ('$(HOME)/st/xtreams/wiki' tokensBasedOn: $/)) asFilename
	"
	((Store.Registry bundleNamed: 'XtreamsDevelopment') leafItems
		reject: [ :p | #('*-Tests' '*-Xperiments' '*-Support' 'Xpressly*') anySatisfy: [ :pattern | pattern match: p name ] ]
	) collect: [ :p || file |
		file := p name copyFrom: 'Xtreams-' size + 1 to: p name size.
		file := directory / (file, '.wiki').
		file exists ifTrue: [ file delete ].
		(file writing encoding: #ascii) write: p comment; close ]