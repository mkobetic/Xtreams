"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
refill: size from: input
	stateLock critical: [
		source writing write: size from: input.
		waitingLock signal]