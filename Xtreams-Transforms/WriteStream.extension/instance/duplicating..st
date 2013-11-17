"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: transforming
"
duplicating: aWriteStream
	"Duplicate all the contents written into @aWriteStream"
	"	aWriteStream <WriteStream>	a stream to copy into
		^<DuplicateWriteSteam>
	""
		| original copy |
		original := Array new writing.
		copy := ByteArray new writing.
		(original duplicating: copy) write: (0 to: 15).
		original conclusion -> copy conclusion
	"
	^DuplicateWriteStream on: self duplicate: aWriteStream
