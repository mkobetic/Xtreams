private
streamingInsertFrom: aReadStream
	| count cache |
	count := 0.
	cache := self contentsSpecies newRecycledDefaultSize.
	[[aReadStream read: cache size into: cache at: 1] on: Incomplete do: [:exception |
		self insert: exception.
		cache recycle.
		^count + exception count].
	self insert: cache size from: cache at: 1.
	count := count + cache size] repeat