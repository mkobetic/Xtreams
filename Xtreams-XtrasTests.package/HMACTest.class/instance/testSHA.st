tests
testSHA
	
	| hash contents digest key |
	hash := XTHMAC new.
	key := 'Open sesame!'.
	[hash algorithm: 'sha1' key: key.
	contents := 'Message in the bottle!'.
	hash updateFrom: contents.
	digest := hash finish.
	self
		assert:
			digest =
					#[119 3 83 24 46 4 34 141 164 213 29 55 17 246 191 49 8 52 142 242].
	hash reset.
	hash updateFrom: contents.
	digest := hash finish.
	self
		assert:
			digest =
					#[119 3 83 24 46 4 34 141 164 213 29 55 17 246 191 49 8 52 142 242]]
		ensure: [hash release]