"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
put: anObject
	[destination put: anObject] on: Incomplete do: [:incomplete |
		destinationAtEnd := true.
		incomplete pass]
