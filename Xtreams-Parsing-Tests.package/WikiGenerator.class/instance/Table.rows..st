"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: Structural
"
Table: header rows: rows
	<action: 'Table' arguments: #(1 2)>
	^Element tag: Table elements:
		(Array
			with: (Element tag: TableHead elements: (Array with: header))
			with: (Element tag: TableBody elements: rows))