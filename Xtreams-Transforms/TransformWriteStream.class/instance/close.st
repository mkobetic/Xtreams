"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: initialize-release
"
close
	buffer ifNil: [^self].
	"Write nothing to the buffer, but signal that there is data to read, causing the drain to throw Incomplete"
	readReady signal.

	"Wait for the drain to finish up completely. Rearm the closeReady incase somebody calls #close again."
	closeReady wait.
	closeReady signal.

	closeBlock cull: destination cull: self.

	buffer recycle.
	buffer := nil
