accessing
put: anObject
	[destination put: anObject] on: Incomplete do: [:incomplete |
		destinationAtEnd := true.
		incomplete pass]