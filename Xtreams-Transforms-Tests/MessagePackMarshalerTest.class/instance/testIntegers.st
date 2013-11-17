"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testIntegers
	| inrange outofrange |
	outofrange := #(18446744073709551616 -9223372036854775809).
	inrange := #(
		0 1 126 127 128 255 256
		32767 32768 32769
		65535 65536 65537
		4294967294 4294967295 4294967296
		18446744073709551614 18446744073709551615
		-1 -2 -32 -33
		-127 -128 -255 -256
		-32767 -32768 -32769
		-65535 -65536 -65537
		-2147483647 -2147483648 -2147483649
		-9223372036854775807 -9223372036854775808).

	marshaling write: inrange.
	outofrange do: [:each | self should: [marshaling put: each] raise: Error].
	self analyse.
	self assert: marshaling rest = inrange
