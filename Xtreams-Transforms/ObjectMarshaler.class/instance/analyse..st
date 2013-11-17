"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: api
"
analyse: reading
	| description |
	description := '<error>'.
	reading
		log:
			[description]
		do:
			[ | classId class objectId |
			self analyse: reading class_id: [:id :behavior |
				description := 'class id: ', id printString, ' class: ', behavior fullName, ' '.
				classId := id.
				class := behavior].
			(immediate at: classId) ifTrue:
				[description := description, 'immediate'.
				self perform: (analyse at: classId) with: reading with: class.
				^self].
			objectId := -1.
			reading log: ['object id: ', objectId printString] do: [objectId := self get: reading integer: nil].
			(reading objects includes: objectId) ifTrue:
				[description := description, 'reference: ', objectId printString.
				^self].
			description := description, 'object id: ', objectId printString.
			reading objects add: objectId.
			self perform: (analyse at: classId) with: reading with: class.
			(rehash at: classId) ifTrue: [description := description, ' rehash']]
