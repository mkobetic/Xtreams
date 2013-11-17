"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: initialize-release
"
close
	buffer ifNil: [^self].
	sourceAtEnd := true.
	closeBlock cull: source cull: self.
	buffer recycle.
	buffer := nil
