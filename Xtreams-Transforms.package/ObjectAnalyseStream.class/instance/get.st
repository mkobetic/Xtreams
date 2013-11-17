"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
get
	| details |
	marshaler analyse: self.
	details := log conclusion.
	log := String new writing.
	self complete.
	^details
