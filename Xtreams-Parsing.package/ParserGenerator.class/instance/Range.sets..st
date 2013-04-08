"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: terminals
"
Range: excluding sets: sets
	<action: 'Range' arguments: #( 3 4 )>

	^'(generator Range: ', (excluding ifNil: ['nil'] ifNotNil: [excluding]), ' sets: ', (self collection: sets), ')'