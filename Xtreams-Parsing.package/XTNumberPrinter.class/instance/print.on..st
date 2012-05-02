public
print: aNumber on: aWriteable
	number := aNumber.
	self calcSign.
	self calcWholePart.
	self calcFractionPart.
	self flush: aWriteable writing