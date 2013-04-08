"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - interpreting
"
testMarshaling
	| object result in out |
	object := Object new.
	out := self output marshaling.
	in := self input marshaling.
	2 timesRepeat: 
		[out put: ((1 to: 11) collect: [:each | (1 to: 11) collect: [:ea | object]]).
		result := in get.
		self assert: result size = 11.
		self assert: (result allSatisfy: [:each | each allSatisfy: [:ea | ea == result first first]])]