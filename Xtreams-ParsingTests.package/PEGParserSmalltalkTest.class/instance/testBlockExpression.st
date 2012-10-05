testing
testBlockExpression

	<timeout: 10 "seconds">
	| expression tree |
	expression := '[super ++ (anInteger - skipped)] on: Incomplete do: [ :ex | ex pass ]'.
	tree := parser parse: 'Expression' stream: expression reading actor: PEGTreeBuilder new.
	tree key value size = expression size