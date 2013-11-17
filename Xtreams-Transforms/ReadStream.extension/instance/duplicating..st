"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: transforming
"
duplicating: aWriteStream
	"Duplicate all the contents written into @aWriteStream"
	"	aWriteStream <WriteStream>	a stream to copy into
		^<DuplicatingReadSteam>
	""
		| copy |
		copy := ByteArray new writing.
		((0 to: 15) reading duplicating: copy) rest -> copy conclusion
	"
	^DuplicateReadStream on: self duplicate: aWriteStream
