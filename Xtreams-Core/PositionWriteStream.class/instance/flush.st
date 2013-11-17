"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: initialize-release
"
flush
	buffer ifNil: [^self].
	destination write: buffer.
	buffer clear
