"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: analyse - complex
"
analyse: reading class: aClass
	<analyse: 'Core.Behavior'>

	| classId class  |
	reading
		log:	['class: ', class absoluteName]
		do:	[classId := self analyse: reading class_id: [:id :behavior | classId := id. class := behavior]]
