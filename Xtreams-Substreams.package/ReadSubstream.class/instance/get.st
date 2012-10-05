accessing
get
	^[source get] on: Incomplete do: [:incomplete | sourceAtEnd := true. incomplete pass]