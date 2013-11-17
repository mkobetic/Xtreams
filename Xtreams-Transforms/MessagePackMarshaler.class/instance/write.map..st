"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: private - writing
"
write: writing map: map
	self write: writing map_size: map size.
	map keysAndValuesDo: [:key :value |
		self marshal: writing object: key.
		self marshal: writing object: value]
