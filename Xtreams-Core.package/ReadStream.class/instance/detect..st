"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: enumerating
"
detect: aBlock 
	"Evaluate aBlock with each of the receiver's elements as the argument. Answer the first element for which aBlock evaluates to true."
	"	aBlock	<BlockClosure>	#detect: style block
		^		<Object>	first element for which aBlock evalutes to true
	"
	^self detect: aBlock ifNone: [NotFoundError raise]