"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: accessing
"
get
	| details |
	marshaler analyse: self.
	details := log conclusion.
	log := String new writing.
	self complete.
	^details
