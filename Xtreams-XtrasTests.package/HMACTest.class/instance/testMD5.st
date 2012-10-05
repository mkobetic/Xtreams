tests
testMD5
	
	| hash contents digest key |
	hash := XTHMAC new.
	key := 'Open sesame!'.
	[hash algorithm: 'md5' key: key.
	contents := 'Message in the bottle!'.
	hash updateFrom: contents.
	digest := hash finish.
	self
		assert:
			digest = #[115 209 90 58 172 75 129 194 172 139 82 10 55 52 62 127].
	hash reset.
	hash updateFrom: contents.
	digest := hash finish.
	self
		assert:
			digest = #[115 209 90 58 172 75 129 194 172 139 82 10 55 52 62 127]]
		ensure: [hash release]