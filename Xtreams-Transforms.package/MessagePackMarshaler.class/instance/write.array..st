"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private - writing
"
write: writing array: array
	self write: writing array_size: array size.
	array do: [:each | self marshal: writing object: each]
