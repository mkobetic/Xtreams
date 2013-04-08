"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: converting
"
reading: timeout
"Create read stream with timeout support.
	timeout <Duration> reads will wait at most @timeout for incoming data
	^<ExternalTimeoutReadStream>
"
	^(ExternalTimeoutReadStream on: self)
		timeout: timeout;
		yourself