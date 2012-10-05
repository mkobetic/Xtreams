*Xtreams-Transforms-transforming
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
	^XTDuplicateWriteStream on: self duplicate: aWriteStream