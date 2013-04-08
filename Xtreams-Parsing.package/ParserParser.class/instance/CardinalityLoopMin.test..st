"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: cardinality
"
CardinalityLoopMin: min test: test
	<action: 'CardinalityLoopMin' arguments: #( 1 5 )>
	^[:expression | [parser repeat: expression min: min test: test]]