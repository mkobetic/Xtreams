testing
testMethodDoubleDashSelector

	<timeout: 10 "seconds">
	| expression tree |
	expression := '-- count	^count'.
	tree := parser parse: 'Method' stream: expression reading actor: PEGTreeBuilder new.
	tree key value size = expression size