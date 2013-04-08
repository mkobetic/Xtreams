"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
get
	| details |
	marshaler analyse: self.
	details := log conclusion.
	log := String new writing.
	self complete.
	^details