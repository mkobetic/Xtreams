Transform write stream provides the most expressive form of transformation. The transformation is described by a binary block that is given two arguments, @input and @output. The @input is a virtual stream of elements written into the stream. The @output is the destination stream under the transform stream. The block can read arbitrary amount of elements from @input (including none) and write arbitrary amount of elements into @output (including none). The block will be invoked as many times as necessary to consume everything written into the stream, or until an Incomplete is raised by the destination.

The closing behavior of the stream can be customized through the closeBlock. The default closeBlock simply propagates #close to the destination as with any other transform stream.

In some cases it might be desirable to tweak the buffering strategy of the virtual input stream. In that case the buffer of the stream can be set manually to any kind of Buffer that matches the requirements of the transformation.

From the point of view of the API, the TransformWriteStream is very much like the TransformReadStream. Notably any valid transform block should work the same way on either read or write stream without modification. However to preserve the invariants and expressivity of the transform block, the implementation is vastly different. Primarily it is necessary to convert all the writes into a virtual stream of written elements that can be passed into the transform block as the input stream. Consequently the transformation itself needs to be suspended if there weren't enough elements written yet, to complete an iteration of the transform block. Therefore it needs to run in its own process. Any writes get redirected into an internal buffer and a background process repeatedly invokes the transform block to drain the contents of the buffer and produces output into the destination. Obviously buffer access has to be synchronized between any writing threads and the background process. The readReady/writeReady semaphores work in a lock-step mode, to interleave the background buffer draining with any writes.

Instance Variables
	buffer	<Buffer> holds the contents of the virtual input stream
	block	<BlockClosure> binary transformation block that reads elements from input (first argument) and writes elements into output (second argument)
	closeBlock	<BlockClosure> binary block invoked in response to the #close message, allows customizing the close behavior
	process	<Process> background process that runs the transformation block
	incompleteCount	<Integer> indicates that the transformation raised or received Incomplete and how many elements were actually consumed by the transformation block so that we can reraise Incomplete with correct count in the client thread
	readReady	<Semaphore> signals to the background process that elements were written into the buffer
	writeReady	<Semaphore> gates any writes into the stream, making sure background process is not draining the buffer at the same time
	closeReady	<Semaphore> signals back to the user thread that the background process finished draining the buffer and the stream is properly closed, so the #close call can return

