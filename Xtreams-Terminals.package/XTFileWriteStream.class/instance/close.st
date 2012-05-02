initialize-release
close
	destination closed ifTrue: [^self].
	destination truncateTo: position.
	destination close