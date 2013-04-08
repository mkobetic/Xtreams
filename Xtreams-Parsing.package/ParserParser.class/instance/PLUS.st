"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: cardinality
"
PLUS
	<action: 'PLUS' arguments: #()>
	^[:expression | [parser repeat: expression min: 1 optional: Infinity positive]]