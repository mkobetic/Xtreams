"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
put: object
	marshaler marshal: self object: object.
	self complete.
	^object
