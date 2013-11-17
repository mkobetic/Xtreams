"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: writing - complex
"
put: writing object: object
	<writes: 'Core.Object'>

	object class isVariable ifTrue: [self put: writing integer: object basicSize].
	1 to: object class instSize do: [:index | self marshal: writing object: (object instVarAt: index)].
	1 to: object basicSize do: [:index | self marshal: writing object: (object basicAt: index)]
