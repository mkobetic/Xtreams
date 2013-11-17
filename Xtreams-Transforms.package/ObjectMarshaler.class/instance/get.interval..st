"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: reading - complex
"
get: reading interval: aClass
	<reads: 'Core.Interval'>

	| start stop step |
	start := self unmarshal: reading.
	stop := self unmarshal: reading.
	step := self unmarshal: reading.
	^Interval from: start to: stop by: step
