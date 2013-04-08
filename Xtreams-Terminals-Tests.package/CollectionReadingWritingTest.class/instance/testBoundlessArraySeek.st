"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - core - positioning
"
testBoundlessArraySeek
	output := Array new writing.
	self output
		++ 9;
		write: 10;
		close.
	self assert: self input rest = ((Array new: 10 withAll: nil) at: 10 put: 10; yourself)