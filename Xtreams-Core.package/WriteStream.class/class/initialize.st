"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: class initialization
"
initialize
	Backspace := String with: Character backspace.
	Bell := String with: (Character value: 7).
	CarriageReturn := String with: Character cr.
	Delete := String with: (Character value: 127).
	DoubleQuote := String with: $".
	Escape := String with: (Character value: 27).
	FormFeed := String with: Character newPage.
	LineFeed := String with: Character lf.
	Quote := String with: $'.
	Space := String with: Character space.
	Tab := String with: Character tab.
	VerticalTab := String with: (Character value: 11)