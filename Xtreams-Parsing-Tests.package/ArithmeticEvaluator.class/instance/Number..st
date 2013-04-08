"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: rules
"
Number: digits
	<action: 'Number'>	
	^digits inject: 0 into: [ :total :digit | total * 10 + ('0123456789' indexOf: digit) - 1 ]