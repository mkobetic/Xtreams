accessing
write: total from: source at: initialStart
	
	| requested written start |
	start := initialStart.
	requested := total.
	[written := requested min: input size.
	input replaceFrom: 1 to: written with: source startingAt: start.
	hash update: written from: input.
	destination write: written from: source at: start.
	start := start + written.
	(requested := requested - written) > 0] whileTrue.
	^total