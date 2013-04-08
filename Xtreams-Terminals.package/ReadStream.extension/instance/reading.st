"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: converting
"
reading
	^[[self next]
		on: EndOfStreamNotification
		do: [:notification |
			notification originator == self
				ifTrue:	[Incomplete zero raise]
				ifFalse:	[notification pass]]] reading
		contentsSpecies: self contentsSpecies;
		yourself