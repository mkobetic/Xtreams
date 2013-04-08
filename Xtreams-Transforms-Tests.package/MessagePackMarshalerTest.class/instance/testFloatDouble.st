"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testFloatDouble
	marshaling write: #(3.14 3.14159 3.141592653589793).
	self analyse.
	self assert: marshaling rest = #(3.14 3.14159 3.141592653589793)