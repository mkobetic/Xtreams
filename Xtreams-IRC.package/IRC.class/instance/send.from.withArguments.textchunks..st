"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private - sending
"
send: aCommand from: anOrigin withArguments: anArray textchunks: aText
	| buffer header |
	buffer := String new writing.

	anOrigin == nil ifFalse: [buffer write: ':'; write: anOrigin; space].
	buffer write: aCommand.
	anArray do: [:each | buffer space; write: each].
	buffer write: ' :'.

	header := buffer conclusion.
	header size >= 510 ifTrue: [self error: 'packet too long, shorten parameters'].

	(aText reading limiting: (510 - header size)) slicing do: [:textchunkstream |
		| textchunk |
		textchunk := textchunkstream rest.
		mutex critical: [output write: header; write: textchunk; cr].
		self triggerEvent: #output withArguments: (Array with: aCommand with: anOrigin with: (anArray, (Array with: textchunk)))]