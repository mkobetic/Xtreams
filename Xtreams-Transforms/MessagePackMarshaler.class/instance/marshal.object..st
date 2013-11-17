"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: api
"
marshal: writing object: object
	(marshaling at: object class ifAbsent: [self error: 'Unmarshalable class with the MessagePack protocol']) value: writing value: object
