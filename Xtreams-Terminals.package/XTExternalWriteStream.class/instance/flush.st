initialize-release
flush
	destination closed ifTrue: [^self].
	destination commit