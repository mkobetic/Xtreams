initialize-release
flush
	active == nil ifTrue: [^self].
	active close.
	active := nil