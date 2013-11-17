"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testDuplicateWritingPositionable
	| original copy duplicate |
	duplicate := (original := Array new writing) duplicating: (copy := Array new writing).
	duplicate write: (0 to: 255); -- 55; ++ 25.
	self assert: original conclusion = (0 to: 225) asArray.
	self assert: copy conclusion = (0 to: 225) asArray.