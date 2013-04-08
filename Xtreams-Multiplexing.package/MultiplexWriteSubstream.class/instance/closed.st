"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
closed
	stateLock critical: [
		substreamClosed := true.
		waitingLock signal]