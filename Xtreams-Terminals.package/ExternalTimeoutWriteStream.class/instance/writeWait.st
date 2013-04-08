"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
writeWait

	[	(destination writeWaitWithTimeoutMs: timeout) ifFalse: [^self].
		Timeout raiseSignal
	] repeat