"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: utilities
"
timeout: timeoutDuration server: serverBlock client: clientBlock
	"For tests that must be able to write and read at the same time, where they may block on each.
	 Sockets, Pipes have an operating system buffer which dictates its bandwidth."

	self assert: serverBlock value.
	self assert: clientBlock value.