Accepts characters, converts them to bytes (0..255) using pre-configured encoding and writes the bytes into destination. Unless set to lineEndTransparent, converts any CRs into configured line-end convention (LF or CRLF).

Instance Variables
	encoder	<Encoder> converts characters to bytes
	buffer	<Buffer on: ByteArray> batch writing buffer
	bufferReading	<ReadStream> read stream on buffer
	bufferWriting	<WriteStream> write stream on buffer
	decodedLineEnd	<Character> CR or nil if transparent
	encodedLineEnd	<ByteArray> encoded bytes of CR in the configured convention (LF or CRLF), or nil if transparent

