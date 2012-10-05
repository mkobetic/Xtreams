accessing
flush
	destination closed ifTrue: [^self].
	destination commit