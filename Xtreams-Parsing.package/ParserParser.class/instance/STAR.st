"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: cardinality
"
STAR
	<action: 'STAR' arguments: #()>
	^[:expression | [parser repeat: expression min: 0 optional: Infinity positive]]