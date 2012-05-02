accessing
read: total into: destination at: initialStart
	
	| requested start |
	start := initialStart.
	requested := total.
	[| toRead read |
	toRead := requested min: input size.
	read := [source read: toRead into: destination at: start.
	toRead]
		on: Incomplete
		do: [:ex | ex count].
	input replaceFrom: 1 to: read with: destination startingAt: start.
	hash update: read from: input.
	requested := requested - read.
	read < toRead
		ifTrue:
			[(Incomplete
				on: destination
				count: total - requested
				at: initialStart) raise].
	start := start + read.
	requested > 0] whileTrue.
	^total