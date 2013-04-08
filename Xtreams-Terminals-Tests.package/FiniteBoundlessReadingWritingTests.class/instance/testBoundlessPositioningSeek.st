"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - core - positioning
"
testBoundlessPositioningSeek
	self output
		position: 9;
		write: 10;
		close.
	self assert: self input rest = #[0 0 0 0 0 0 0 0 0 10]