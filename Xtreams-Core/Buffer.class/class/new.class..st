"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: instance creation
"
new: anInteger class: aClass
	^self on: (aClass newRecycled: anInteger)