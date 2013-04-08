"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: utility
"
encode: anObject

	^(String new writing marshaling: JSON)
		put: anObject;
		close;
		terminal