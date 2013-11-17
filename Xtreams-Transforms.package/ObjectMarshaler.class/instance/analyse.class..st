"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: analyse - complex
"
analyse: reading class: aClass
	<analyse: 'Core.Behavior'>

	| classId class  |
	reading
		log:	['class: ', class absoluteName]
		do:	[classId := self analyse: reading class_id: [:id :behavior | classId := id. class := behavior]]
