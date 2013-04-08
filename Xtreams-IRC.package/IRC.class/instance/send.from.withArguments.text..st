"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private - sending
"
send: aCommand from: anOrigin withArguments: anArray text: aText
	| buffer |
	buffer := String new writing.

	anOrigin == nil ifFalse: [buffer write: ':'; write: anOrigin; space].
	buffer write: aCommand.
	anArray do: [:each | buffer space; write: each].
	aText == nil ifFalse: [buffer write: ' :'; write: aText].
	buffer cr.
	buffer position > 512 ifTrue: [self error: 'packet too long, shorten parameters'].

	mutex critical: [output write: buffer conclusion].
	self
		triggerEvent: #output
		withArguments: (Array
			with: aCommand
			with: anOrigin
			with: (aText == nil ifTrue: [anArray] ifFalse: [anArray, (Array with: aText)]))