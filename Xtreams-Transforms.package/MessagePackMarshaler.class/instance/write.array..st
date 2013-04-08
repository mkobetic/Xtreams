"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private - writing
"
write: writing array: array
	self write: writing array_size: array size.
	array do: [:each | self marshal: writing object: each]