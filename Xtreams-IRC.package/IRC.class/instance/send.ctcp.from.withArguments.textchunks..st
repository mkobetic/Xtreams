"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private - sending
"
send: aCommand ctcp: subCommand from: anOrigin withArguments: anArray textchunks: aText
	| buffer header |
	buffer := String new writing.

	anOrigin == nil ifFalse: [buffer write: ':'; write: anOrigin; space].
	buffer write: aCommand.
	anArray do: [:each | buffer space; write: each].
	buffer write: ' :'.

	header := buffer conclusion.
	header size >= (507 - subCommand size) ifTrue: [self error: 'packet too long, shorten parameters'].

	(aText reading limiting: (507- subCommand size  - header size)) slicing do: [:textchunkstream |
		| textchunk |
		textchunk := textchunkstream rest.
		mutex critical: [output write: header; put: 1 asCharacter; write: subCommand; space; write: textchunk; put: 1 asCharacter; cr].
		self triggerEvent: #output withArguments: (Array with: (aCommand, '_', subCommand) asSymbol with: anOrigin with: (anArray, (Array with: textchunk)))]