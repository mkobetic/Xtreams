"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: converting
"
reading
	| context |
	(context := self class new) sender: self.
	^[	context := context sender.
		context == nil ifTrue: [Incomplete raise].
		context
	] reading