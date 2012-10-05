Converts bytes into characters using pre-configured encoding. At the same time, if set to lineEndAuto (default) it can perform line-end translation, converting any line-end convention into CRs. The source stream must provide bytes (0...255).

Instance Variables
	transparent	<Boolean> should the stream perform line-end translations
	crPreceeding	<Boolean> was previous character read a CR (used when not transparent)
	encoder	<Encoder> converts bytes to characters
	buffer	<Buffer on: ByteArray> used to optimize bulk reads
	bufferWriting	<WriteStream> write stream on buffer
	bufferReading	<ReadStream> read stream on buffer

