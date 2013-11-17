"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private - writing
"
write: writing raw: bytearray
	self write: writing raw_size: bytearray size.
	writing uint8 write: bytearray
