"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: class initialization
"
initialize
        Backspace := String with: Character backspace.
        Bell := String with: (Character value: 7).
        CarriageReturn := String with: (Character value: 13).
        Delete := String with: (Character value: 127).
        DoubleQuote := String with: $".
        Escape := String with: (Character value: 27).
        FormFeed := String with: Character newPage.
        LineFeed := String with: Character lf.
        Quote := String with: $'.
        Space := String with: Character space.
        Tab := String with: Character tab.
        VerticalTab := String with: (Character value: 11)
