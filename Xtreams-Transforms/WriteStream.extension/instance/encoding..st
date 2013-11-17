"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: transforming
"
encoding: anEncoding
	"Transform characters into bytes using @anEncoding such as #utf8 or #ascii, etc. Any encoding supported by StreamEncoder is allowed.
	The encoding steam also performs automatic conversion of CRs into the native line-end convention of the underlying platform,
	unless set into a different line-end convention mode"
	"	anEncoding	<Symbol> encoding identifier recognized by StreamEncoder class>>new:
		^<EncodedWriteStream>
	""
		(ByteArray new writing encoding: #ascii) write: 'abcdefghi'; conclusion
	""
		(ByteArray new writing encoding: #ascii) write: 'Hello\World' withCRs; conclusion
	""
		(ByteArray new writing encoding: #ascii) setLineEndCRLF; write: 'Hello\World' withCRs; conclusion
	"
	^EncodeWriteStream on: self encoding: anEncoding
