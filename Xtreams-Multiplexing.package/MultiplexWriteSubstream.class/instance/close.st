"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
close
	stateLock critical: [
		substreamClosed ifFalse: [
			multiplexer transmitChannelClose: id.
			substreamClosed := true.
			waitingLock signal]]