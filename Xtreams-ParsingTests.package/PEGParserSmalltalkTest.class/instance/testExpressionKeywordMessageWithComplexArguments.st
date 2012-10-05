testing
testExpressionKeywordMessageWithComplexArguments

	<timeout: 10 "seconds">
	| expression tree |
	expression := 'aSequenceableCollection replaceFrom: startIndex to: startIndex + tail - 1 with: cache startingAt: read + 1'.
	tree := parser parse: 'Method' stream: expression reading actor: PEGTreeBuilder new.
	tree key value size = expression size