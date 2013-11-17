"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - core
"
testWriteTruncating

	self output positioning
		write: #[1 2 3 4 5 6];
		-- 3;
		write: #[1 2];
		close.
	self assert: self input rest = #[1 2 3 1 2].
