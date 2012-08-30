initialize-release
close
	buffer == nil ifTrue: [^self].
	super close.
	buffer recycle.
	buffer := nil