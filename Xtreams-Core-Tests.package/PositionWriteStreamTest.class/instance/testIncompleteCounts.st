"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testIncompleteCounts

	self assert: ([ ([ :x | ] writing limiting: 10) positioning write: (1 to: 5); -- 8 ] on: Incomplete do: [:ex | ex count]) = 5.
	self assert: ([ ([ :x | ] writing limiting: 10) positioning write: (1 to: 5); ++ 8 ] on: Incomplete do: [:ex | ex count]) = 0.
	self assert: ([ ([ :x | ] writing limiting: 10) positioning write: (1 to: 5); -= 12 ] on: Incomplete do: [:ex | ex count]) = 5.
	self assert: ([ ([ :x | ] writing limiting: 10) positioning write: (1 to: 5); += 12 ] on: Incomplete do: [:ex | ex count]) = 5.
	self assert: ([ (Array new: 10) writing positioning write: (1 to: 5); -- 8 ] on: Incomplete do: [:ex | ex count]) = 5.
	self assert: ([ (Array new: 10) writing positioning write: (1 to: 5); ++ 8 ] on: Incomplete do: [:ex | ex count]) = 0.
	self assert: ([ (Array new: 10) writing positioning write: (1 to: 5); -= 12 ] on: Incomplete do: [:ex | ex count]) = 5.
	self assert: ([ (Array new: 10) writing positioning write: (1 to: 5); += 12 ] on: Incomplete do: [:ex | ex count]) = 5.
