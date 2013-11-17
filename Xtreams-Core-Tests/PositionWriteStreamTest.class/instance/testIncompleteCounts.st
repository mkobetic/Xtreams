"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
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
