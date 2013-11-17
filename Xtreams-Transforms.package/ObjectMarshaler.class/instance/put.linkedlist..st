"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: writing - complex
"
put: writing linkedlist: aLinkedList
	<writes: 'Core.LinkedList'>

	self put: writing integer: aLinkedList size.
	aLinkedList do: [:object | self marshal: writing object: object]
