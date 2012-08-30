initialize-release
close
	buffer ifNil: [^self].
	sourceAtEnd := true.
	closeBlock cull: source cull: self.
	buffer recycle.
	buffer := nil