*Xtreams-Terminals-converting
reading
	| context |
	(context := self class new) swapSender: self.
	^[context == nil ifTrue: [Incomplete raise].
	   context := context sender]
		reading