updating
update: aParameter
	"Update the instance variables which depend on sqSocketStruct."

	self handle ifNotNil: [self socketType].
	^ super update: aParameter
