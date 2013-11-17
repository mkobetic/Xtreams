"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: private - writing
"
write: writing array: array
	self write: writing array_size: array size.
	array do: [:each | self marshal: writing object: each]
