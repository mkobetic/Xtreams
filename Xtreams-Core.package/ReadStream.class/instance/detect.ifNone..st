"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: enumerating
"
detect: aBlock ifNone: exceptionBlock 
	"Evaluate aBlock with each of the receiver's elements as the argument. Answer the first element for which aBlock evaluates to true.
	Evaluate exceptionBlock if no such element is found."
	"	aBlock			<BlockClosure>	#detect: style block
		exceptionBlock	<BlockClosure>	evaluated if there wasn't any element for which aBlock returns true
		^				<Object>	first element for which aBlock evalutes to true
	"
	self do: [:each | (aBlock value: each) ifTrue: [^each]].
	^exceptionBlock value