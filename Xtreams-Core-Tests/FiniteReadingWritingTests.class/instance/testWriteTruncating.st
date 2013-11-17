"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - core
"
testWriteTruncating

	self output positioning
		write: #[1 2 3 4 5 6];
		-- 3;
		write: #[1 2];
		close.
	self assert: self input rest = #[1 2 3 1 2].
