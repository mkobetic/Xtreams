tests
testSHA256
	
	| hash contents digest key |
	hash := XTHMAC new.
	key := 'Open sesame!'.
	[hash algorithm: 'sha256' key: key.
	contents := 'Message in the bottle!'.
	hash updateFrom: contents.
	digest := hash finish.
	self
		assert:
			digest =
					#[15 84 236 94 191 167 4 195 142 34 221 194 98 235 173 244 51 180 227 233 245 49 171 78 173 128 177 107 123 16 100 43].
	hash reset.
	hash updateFrom: contents.
	digest := hash finish.
	self
		assert:
			digest =
					#[15 84 236 94 191 167 4 195 142 34 221 194 98 235 173 244 51 180 227 233 245 49 171 78 173 128 177 107 123 16 100 43]]
		ensure: [hash release]