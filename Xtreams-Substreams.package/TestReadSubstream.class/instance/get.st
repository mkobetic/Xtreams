"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
get
	| object |
	substreamAtEnd ifTrue: [Incomplete zero raise].
	object := [source get] on: Incomplete do: [:incomplete | sourceAtEnd := substreamAtEnd := true. incomplete pass].
	(substreamAtEnd := test value: object) ifTrue:
		[inclusive ifTrue: [^object].
		Incomplete zero raise].
	^object
