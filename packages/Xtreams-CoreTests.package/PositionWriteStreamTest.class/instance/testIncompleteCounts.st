tests
testIncompleteCounts

	self assert: ([ ([ :x | ] writing limiting: 10) positioning write: (1 to: 5); -- 8 ] on: Incomplete do: [:ex | ex count]) = 5.
	self assert: ([ ([ :x | ] writing limiting: 10) positioning write: (1 to: 5); ++ 8 ] on: Incomplete do: [:ex | ex count]) = 0.
	self assert: ([ ([ :x | ] writing limiting: 10) positioning write: (1 to: 5); -= 12 ] on: Incomplete do: [:ex | ex count]) = 5.
	self assert: ([ ([ :x | ] writing limiting: 10) positioning write: (1 to: 5); += 12 ] on: Incomplete do: [:ex | ex count]) = 5