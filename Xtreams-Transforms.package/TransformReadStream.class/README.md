Transform read stream provides the most expressive form of transformation. The transformation is described by a binary block that is given two arguments, @input and @output. Both @input and @output are streams themselves. The block can read arbitrary amount of elements from @input (including none) and write arbitrary amount of elements into @output (including none).The block will be invoked as many times as necessary to produce the required number of elements, or until an Incomplete is raised. Consequently if the block handles Incomplete from the input, it has to raise another Incomplete at some point, otherwise the stream will never end.

	Note that if the contentSpecies of the source doesn't fit the output of the transformation, the #contentsSpecies of the transform stream has to be set explicitly. The #contentSpecies determines the type of collection employed by the internal buffer that is used as the storage for the virtual output stream of the transformation block. In some cases it might be desirable to tweak the buffering strategy of the virtual output stream. In that case the buffer of the stream can be set manually to any kind of Buffer that matches the requirements of the transformation.
	The closing behavior of the stream can be customized through the closeBlock. The default closeBlock simply propagates #close to the source as with any other transform stream.

Instance Variables
	buffer	<Buffer> holds the contents of the virtual ouput stream
	bufferWriting	<BufferWriteStream> the virtual output stream that is passed to the transformation block as the second argument
	sourceAtEnd	<Boolean> flag indicating that the source has signalled an Incomplete
	block	<BlockClosure> binary transformation block that reads elements from input (first argument) and writes elements into output (second argument)
	closeBlock	<BlockClosure> binary block invoked in response to the #close message, allows customizing the close behavior

