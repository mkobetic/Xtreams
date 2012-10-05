*Xtreams-TransformsTests-encoding
testReadDecodingCRLF

	| result cr x |
	cr := String with: Character cr.
	self output write: #[104 101 108 108 111 13 10 119 111 114 108 100 10 13 13 10 10 ]; close.
	result := (self input encoding: #ascii) read: 15.
	self assert: result = (x := 'hello', cr, 'world', cr, cr, cr, cr)