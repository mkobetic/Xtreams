"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testIncompleteCounts

	| x oneToTen |
	oneToTen := [ (x := x + 1) > 10 ifTrue: [ Incomplete zero raise ]. x ].
	x := 0.
	self assert: ([ oneToTen reading positioning read: 5; -- 8 ] on: Incomplete do: [:ex | ex count]) = 5.
	x := 0.
	self assert: ([ oneToTen reading positioning read: 5; ++ 8 ] on: Incomplete do: [:ex | ex count]) = 5.
	x := 0.
	self assert: ([ oneToTen reading positioning -= 12 ] on: Incomplete do: [:ex | ex count]) = 10.
	x := 0.
	self assert: ([ oneToTen reading positioning += 12 ] on: Incomplete do: [:ex | ex count]) = 10.
	self assert: ([ (1 to: 10) reading positioning read: 5; -- 8 ] on: Incomplete do: [:ex | ex count]) = 5.
	self assert: ([ (1 to: 10) reading positioning read: 5; ++ 8 ] on: Incomplete do: [:ex | ex count]) = 5.
	self assert: ([ (1 to: 10) reading positioning -= 12 ] on: Incomplete do: [:ex | ex count]) = 10.
	self assert: ([ (1 to: 10) reading positioning += 12 ] on: Incomplete do: [:ex | ex count]) = 10.
