"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: api
"
marshal: writing object: object
	(marshaling at: object class ifAbsent: [self error: 'Unmarshalable class with the MessagePack protocol']) value: writing value: object