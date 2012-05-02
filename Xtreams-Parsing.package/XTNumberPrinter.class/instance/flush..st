private
flush: aWriteStream
	width - self actualWidth timesRepeat: [aWriteStream put: padding].
	sign ifNotNil: [aWriteStream put: sign].
	whole size to: 1 by: -1 do: [ :i | self put: (whole at: i) on: aWriteStream ].
	fraction isEmpty ifFalse: 
		[aWriteStream put: $..
		fraction do: [:value | self put: value on: aWriteStream]]