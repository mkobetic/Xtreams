"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
close

	| saved |
	output ifNil: [^self].
	compression finishInto: output do: [ :out | destination write: out from: output at: 1. true ].
	compression release.
	super close.
	saved := input.
	input := nil.
	saved == nil ifFalse: [ saved recycle ].
	saved := output.
	output := nil.
	saved == nil ifFalse: [ saved recycle ].