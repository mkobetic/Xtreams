"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: reading - complex
"
get: reading interval: aClass
	<reads: 'Core.Interval'>

	| start stop step |
	start := self unmarshal: reading.
	stop := self unmarshal: reading.
	step := self unmarshal: reading.
	^Interval from: start to: stop by: step
