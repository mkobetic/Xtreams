"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
get
	^[source get] on: Incomplete do: [:incomplete | sourceAtEnd := true. incomplete pass]
