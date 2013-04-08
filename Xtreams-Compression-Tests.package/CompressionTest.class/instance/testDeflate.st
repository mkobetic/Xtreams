"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testDeflate

	| data compression input output start compressed result |
	data := ByteArray new: 500.
	1 to: data size do: [ :i | data at: i put: i \\ 5 ].
	compressed := #[120 156 98 100 98 102 97 96 28 37 70 18 1 0 0 0 255 255 3 0 212 165 3 233].
	input := ByteArray newInFixedSpace: 500.
	output := ByteArray newInFixedSpace: 500.
	compression := Compression new.
	result := #[].
	"Test compression"
	[	compression deflate.
		start := 1.
		[ start > data size ] whileFalse: [ | available |
			available := data size - start + 1 min: input size.
			input replaceFrom: 1 to: available with: data startingAt: start.
			compression update: available from: input into: output do: [ :in :out |
				result := result, (output copyFrom: 1 to: out).
				in < available ].
			start := start + available ].
		compression finishInto: output do: [ :out | result := result, (output copyFrom: 1 to: out). true ].
		self assert: result = compressed
	] ensure: [ compression release ].