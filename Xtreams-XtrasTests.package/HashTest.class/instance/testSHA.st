tests
testSHA
	
	| hash contents digest |
	hash := XTHash new.
	[hash algorithm: 'sha1'.
	contents := 'Message in the bottle!'.
	hash updateFrom: contents.
	digest := hash finish.
	self
		assert:
			digest =
					#[135 14 150 31 117 2 161 137 130 12 126 19 22 44 107 40 138 248 165 42]]
		ensure: [hash release]