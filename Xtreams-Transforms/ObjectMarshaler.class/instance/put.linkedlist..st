"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: writing - complex
"
put: writing linkedlist: aLinkedList
	<writes: 'Core.LinkedList'>

	self put: writing integer: aLinkedList size.
	aLinkedList do: [:object | self marshal: writing object: object]
