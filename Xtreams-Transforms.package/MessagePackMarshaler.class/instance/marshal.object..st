"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: api
"
marshal: writing object: object
	(marshaling at: object class ifAbsent: [self error: 'Unmarshalable class with the MessagePack protocol']) value: writing value: object
