"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
close
	buffer ifNil: [^self].
	sourceAtEnd := true.
	closeBlock cull: source cull: self.
	buffer recycle.
	buffer := nil