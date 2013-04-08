StoreStringMarshaler defines the utf8 encoded string format for various object types it is meant to support. this marshaler uses the Smalltalk storeString capability to store objects as utf8 on a stream. Its format is simple; the length of the storeString printed as an Integer, followed by a LF; then the storeString itself followed by an LF. The header of the stream is an ascii encoded name of the encoder used for the rest of the stream, the default being UTF8. This is followed by an LF.

Unlike the generic ObjectMarshaler, this marshaler cannot marshal recursively, nor can it marshal CompiledMethods or Processes or the Transcript. Only objects that can be safely printed with #storeString can be marshaled using this marshaler.

Instance Variables
	encoding	<ByteSymbol>	description of encoding

