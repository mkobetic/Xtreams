"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
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
