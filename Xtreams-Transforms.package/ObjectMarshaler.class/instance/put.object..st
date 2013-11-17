"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: writing - complex
"
put: writing object: object
	<writes: 'Core.Object'>

	object class isVariable ifTrue: [self put: writing integer: object basicSize].
	1 to: object class instSize do: [:index | self marshal: writing object: (object instVarAt: index)].
	1 to: object basicSize do: [:index | self marshal: writing object: (object basicAt: index)]
