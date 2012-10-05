tests
testMD5
	
	| hash contents digest |
	hash := XTHash new.
	[hash algorithm: 'md5'.
	contents := 'Message in the bottle!'.
	hash updateFrom: contents.
	digest := hash finish.
	self
		assert:
			digest = #[65 87 107 237 233 250 154 151 62 208 45 46 45 66 229 159]]
		ensure: [hash release]