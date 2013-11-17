"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private - writing
"
write: writing map: map
	self write: writing map_size: map size.
	map keysAndValuesDo: [:key :value |
		self marshal: writing object: key.
		self marshal: writing object: value]
