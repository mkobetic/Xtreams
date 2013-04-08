"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - core - positioning
"
testBoundlessCharacterSeek
	output := String new writing.
	self output
		++ 9;
		write: 'a';
		close.
	self assert: self input rest = ((String new: 10 withAll: (Character codePoint: 0)) at: 10 put: $a; yourself)