"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: initialize-release
"
includeClass: aClass
	| class classId |
	class := aClass.
	[(classId := classes indexOf: class) isZero] whileTrue: [class := class superclass].
	classes := classes copyWith: aClass.
	read := read copyWith: (read at: classId).
	write := write copyWith: (write at: classId).
	analyse := analyse copyWith: (analyse at: classId).
	rehash := rehash copyWith: (rehash at: classId).
	immediate := immediate copyWith: aClass hasImmediateInstances.
	^classes size
