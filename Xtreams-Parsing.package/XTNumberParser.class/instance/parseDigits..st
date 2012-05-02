private
parseDigits: aBlock
	| value |
	value := self digitValue.
	(self isDigit: value) ifFalse: [self fail].
	[absolute := aBlock value: value.
	ch := in get.
	value := self digitValue.
	self isDigit: value]
		whileTrue