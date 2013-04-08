"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testParentheses

	self assert: (ArithmeticEvaluator new parse: '(3+4)*3+4') = 25