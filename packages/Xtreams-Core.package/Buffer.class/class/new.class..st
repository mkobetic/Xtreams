instance creation
new: anInteger class: aClass
	^self on: (aClass newRecycled: anInteger)