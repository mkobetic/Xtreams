"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: utilities
"
timeout: timeoutDuration server: serverBlock client: clientBlock
	"For tests that must be able to write and read at the same time, where they may block on each.
	 Sockets, Pipes have an operating system buffer which dictates its bandwidth."

	self assert: serverBlock value.
	self assert: clientBlock value.
