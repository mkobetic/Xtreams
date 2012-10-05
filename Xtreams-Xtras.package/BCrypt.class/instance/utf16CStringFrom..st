private
utf16CStringFrom: aString

	^(	((aString reading transforming: [ :in :out | out put: in get asInteger; put: 0 ])
			contentsSpecies: ByteArray;
			yourself),
		#[0 0] reading
	) rest
"	Doesn't work, Squeak defaults to big-endian
	^(ByteArray new writing encoding: #utf16)
		write: aString;
		put: (Character value: 0);
		close;
		terminal
"