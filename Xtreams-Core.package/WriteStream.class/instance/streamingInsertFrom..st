"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingInsertFrom: aReadStream
	| count cache |
	count := 0.
	cache := aReadStream contentsSpecies newRecycledDefaultSize.
	[[aReadStream read: cache size into: cache at: 1] on: Incomplete do: [:exception |
		self insert: exception.
		cache recycle.
		^count + exception count].
	self insert: cache size from: cache at: 1.
	count := count + cache size] repeat