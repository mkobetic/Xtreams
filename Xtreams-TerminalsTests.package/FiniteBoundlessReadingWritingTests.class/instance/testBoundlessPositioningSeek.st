testing
testBoundlessPositioningSeek
	self output
		position: 9;
		write: 10;
		close.
	self assert: self input rest = #[0 0 0 0 0 0 0 0 0 10]