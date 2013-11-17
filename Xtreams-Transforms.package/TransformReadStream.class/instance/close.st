"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
close
	buffer ifNil: [^self].
	sourceAtEnd := true.
	closeBlock cull: source cull: self.
	buffer recycle.
	buffer := nil
