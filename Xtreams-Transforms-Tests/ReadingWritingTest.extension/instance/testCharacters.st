"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - transforming
"
testCharacters
	(self output encoding: #ascii)
		setLineEndTransparent;
		backspace; bell; cr; delete; ff; lf; q; qq; space; tab; vtab; escape;
		close.
	self assert: (self input read: 12) = #[8 7 13 127 12 10 39 34 32 9 11 27]
