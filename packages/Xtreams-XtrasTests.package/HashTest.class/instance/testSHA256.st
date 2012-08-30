tests
testSHA256
	
	| hash contents digest |
	hash := XTHash new.
	[hash algorithm: 'sha256'.
	contents := 'Message in the bottle!'.
	hash updateFrom: contents.
	digest := hash finish.
	self
		assert:
			digest =
					#[58 81 37 196 206 59 64 114 113 49 63 210 28 86 86 11 13 156 83 203 29 220 121 151 105 8 240 98 147 236 180 239]]
		ensure: [hash release]