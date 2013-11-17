"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: accessing
"
put: object
	marshaler marshal: self object: object.
	self complete.
	^object
