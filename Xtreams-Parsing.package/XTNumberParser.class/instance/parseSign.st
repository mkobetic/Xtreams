private
parseSign
	ch := in get.
	ch = $-
		ifFalse: [sign := 1]
		ifTrue:
			[sign := -1.
			ch := in get]
		