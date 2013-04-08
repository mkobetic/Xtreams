"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: actions
"
putRealDouble: aDouble
	<action: #{Core.Double}>
	<action: #{Core.SmallDouble}>
	<action: #{Core.Fraction}>
	<action: #{Core.FixedPoint}>

	| string |
	string := aDouble asDouble printString.
	string replaceAll: $d with: $e.
	destination write: string