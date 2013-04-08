"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
readWait

	[	(source readWaitWithTimeoutMs: timeout) ifFalse: [^self].
		Timeout raiseSignal
	] repeat