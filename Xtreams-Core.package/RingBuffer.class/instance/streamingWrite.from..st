"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingWrite: total from: source

	| write tail |
	total > cache size ifTrue: [ | count |
		readPosition := 0.
		dataLength := writePosition := cache size.
		count := total.
		[ count > 0 ] whileTrue: [
			count := count - (source read: (count min: cache size) into: cache at: 1) ].
		dataPosition := total \\ cache size.
		^total ].
	write := (dataPosition + writePosition) \\ cache size.
	tail := (cache size - write) min: total.

	source read: tail into: cache at: write + 1.
	source read: total - tail into: cache at: 1.
	
	self privateWrapDataPosition: total.
	writePosition := (writePosition + total) min: cache size.
	writePosition > dataLength ifTrue: [dataLength := writePosition]