"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
get
	^[source get] on: Incomplete do: [:incomplete | sourceAtEnd := true. incomplete pass]