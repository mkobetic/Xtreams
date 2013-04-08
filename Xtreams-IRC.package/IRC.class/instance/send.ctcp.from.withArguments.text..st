"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private - sending
"
send: aCommand ctcp: subCommand from: anOrigin withArguments: anArray text: aText
	| buffer |
	buffer := String new writing.

	anOrigin == nil ifFalse: [buffer write: ':'; write: anOrigin; space].
	buffer write: aCommand.
	anArray do: [:each | buffer space; write: each].
	buffer write: ' :'; put: 1 asCharacter; write: subCommand.
	aText == nil ifFalse: [buffer space; write: aText].
	buffer write: 1 asCharacter; cr.
	buffer position > 512 ifTrue: [self error: 'packet too long, shorten parameters'].

	mutex critical: [output write: buffer conclusion].
	self
		triggerEvent: #output
		withArguments: (Array
			with: (aCommand, '_', subCommand) asSymbol
			with: anOrigin
			with: (aText == nil ifTrue: [anArray] ifFalse: [anArray, (Array with: aText)]))