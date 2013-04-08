"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: converting
"
writing: timeout
"Create write stream with timeout support.
	timeout <Duration> writes will wait at most @timeout for room to write data
	^<ExternalTimeoutWriteStream>
"
	^(ExternalTimeoutWriteStream on: self)
		timeout: timeout;
		yourself