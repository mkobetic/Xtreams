"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: initialize-release
"
input

	^input ifNil: [ input := (self output close; terminal) reading ]
